#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::devel {

	package {[
	        # development tools
			'git',
			'rpm-build',
			'createrepo',
			'rpmdevtools',
			'gcc',
			'make',

			# basic development libraries
			'readline-devel',
			'libuuid-devel',
			'apr-devel',
			'bzip2-devel',
			'zlib-devel',
			'sqlite',
			'zeromq-devel',
			'ncurses-devel',
			'pcre-devel',
			#'openssl-devel',
		]:
		ensure 		=> 'present',
    	require 	=> Yumrepo[ "epel" ],
	}
    
	package {[
			'apr-util-devel',
			'log4cxx-devel'
		]:
		ensure 		=> 'present',
		require 	=> Package["apr-devel"],
	}

    case $operatingsystem {
        centos: { 
	        package {[
			        'compat-readline5-static',
			        'compat-readline5-devel',
			        'readline-static',
		        ]:
				ensure 	=> 'present',
		    	require => Yumrepo[ "epel" ],
            }
        }
        redhat: {
        }
    }
}

