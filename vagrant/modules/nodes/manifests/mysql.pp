#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::mysql {

	package {'mysql':
	    name        => 'mysql-server',
		ensure 		=> 'present',
    	require 	=> Yumrepo[ "epel" ],
	}

	service {'mysqld':
		name 		=> 'mysqld',
		ensure 		=> 'running',
		require 	=> Package["mysql"],
	}
}
