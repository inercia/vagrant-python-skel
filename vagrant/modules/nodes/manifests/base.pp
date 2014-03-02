#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::base {

	# epel repository URL
	$EPEL_REPO='http://ftp.rediris.es/mirror/fedora-epel/6/$basearch/'

	class { '::selinux':
		mode => 'permissive',
	}

	yumrepo { "epel":
	    name      => "epel",
	    baseurl   => $EPEL_REPO,
	    enabled   => 1,
	    gpgcheck  => 0
	}

	group { "puppet":
		ensure => "present",
	}

	File { owner => 0, group => 0, mode => 0644 }

	file { '/etc/motd':
		content => "\n\nWelcome to a \n${operatingsystem} ${operatingsystemrelease} machine - Default IP:${ipaddress}!\nManaged by Puppet.\n\n"
	}

    exec { 'iptables-flush':
      command => "/sbin/iptables --flush",
    }

	########################################
	# RPM packages
	########################################
	package {[
			'zeromq',
			'pcre',
			'readline',
			'compat-readline5',
			'joe',
			'wget',
		]:
		ensure 		=> 'present',
    	require 	=> Yumrepo[ "epel" ],
	}
}


