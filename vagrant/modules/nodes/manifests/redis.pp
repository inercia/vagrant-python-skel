#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::redis {

	package {'redis':
		ensure 		=> 'present',
    	require 	=> Yumrepo[ "epel" ],
	}

	service {'redis':
		name 		=> 'redis',
		ensure 		=> 'running',
		require 	=> Package["redis"],
	}
}
