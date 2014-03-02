#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::mysql_devel {

	package {'mysql-devel':
	    name        => 'mysql-devel',
		ensure 		=> 'present',
    	require 	=> Yumrepo[ "epel" ],
	}
}
