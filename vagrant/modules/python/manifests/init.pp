################################################################################################
# Python installation
################################################################################################

class python {

  # extra RPMs
  # change the URLs for "puppet://" if you are using a puppet master
  $PYTHON27_RPM       = '/extras/python27-2.7.3-1.x86_64.rpm'
  $PYTHON27_DEVEL_RPM = '/extras/python27-devel-2.7.3-1.x86_64.rpm'
  
  package { 'python27':
      provider => 'rpm',
      ensure   => 'present',
      source   => $PYTHON27_RPM,
  }

  package { 'python27-devel':
      provider => 'rpm',
      ensure   => 'present',
      source   => $PYTHON27_DEVEL_RPM,
      require  => Package["python27"],
  }
  
  python::extras { "extras":
      require => Package["python27-devel"],
  }

  python::pip { ["Cython", "virtualenv" ]:
      ensure   => present,
      require  => python::extras["extras"],
  }

  define extras ($prefix     = "/usr/local",
                 $tmpdir     = "/tmp/puppet",
                 $pipversion = "1.4.1",
                 $python_bin = "python2.7",
                 $python_ver = "2.7",
                 $retriever  = "curl -OL -m300") {
  
    Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }
    file { ["$prefix", "$tmpdir"]: ensure => directory }
 
    exec { "retrieve-setuptools":
      command   => "$retriever https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py",
      cwd       => $tmpdir,
      require   => File["$prefix"],
      creates   => "$tmpdir/ez_setup.py",
    }
 
    exec { "retrieve-pip":
      command   => "$retriever http://pypi.python.org/packages/source/p/pip/pip-$pipversion.tar.gz",
      cwd       => $tmpdir,
      require   => File["$prefix"],
      notify    => Exec["extract-pip"],
      creates   => "$tmpdir/pip-$pipversion.tar.gz",
    }
 
    exec { "extract-pip":
      command   => "tar -zxf pip-$pipversion.tar.gz",
      cwd       => $tmpdir,
      creates   => "$tmpdir/pip-$pipversion",
      require   => Exec["retrieve-pip"],
      subscribe => Exec["retrieve-pip"],
    }
 
    exec { "install-setuptools":
      command   =>"$prefix/bin/$python_bin ez_setup.py",
      cwd       => $tmpdir,
      require   => [
                   Exec["retrieve-setuptools"],
                   ],
      before    => Exec["install-pip"],
      creates   => "$prefix/bin/easy_install-$python_ver",
    }
 
    exec { "install-pip":
      command   => "$prefix/bin/$python_bin setup.py install",
      cwd       => "$tmpdir/pip-$pipversion",
      creates   => "$prefix/bin/pip-$python_ver",
      subscribe => Exec["extract-pip"],
      require   => [
                   Exec["extract-pip"],
                   Exec["install-setuptools"]
                   ],
    }
  }
 
  define pip($prefix = "/usr/local",
             $version = undef,
             $ensure) {
    case $ensure {
      present: {
        exec        { "pip-install-$name-$version":
        command =>  "$prefix/bin/pip install $name",
        timeout =>  "-1",
        require =>  Exec["install-pip"],
        }
      }
    }
  }
}
