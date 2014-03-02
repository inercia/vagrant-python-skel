#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::role_web_devel {

	include '::python'
    include '::nodes::base'
    include '::nodes::devel'
    include '::nodes::mysql'
    include '::nodes::mysql_devel'
    include '::nodes::apache'

    # maybe we want to use sqlite in development...
	package {[
			'sqlite-devel',
		]:
		ensure 		=> 'present',
		require 	=> Package["sqlite"],
	}
	
}

