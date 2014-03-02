#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

stage { "pre": before => Stage["main"] }

################################################################################################
# global nodes definitions

node zone_base {
	$my_puppet_server = "192.168.9.10"
}

node zone_production inherits zone_base {
    $my_zone = "production"
}

node zone_devel inherits zone_base {
    $my_zone = "devel"
}

node zone_vagrant inherits zone_devel {
    $my_zone = "vagrant"
}

node zone_qa inherits zone_devel {
    $my_zone = "qa"
}

################################################################################################
# vagrant nodes definitions

node /^vagrant-web-devel-*/ inherits zone_vagrant {
	include nodes::role_web_devel
}

################################################################################################
# specific nodes definitions

node /^prod-web-devel-*/ inherits zone_devel {
	include nodes::role_web_devel
}

node /^prod-web-*/ inherits zone_production {
	include nodes::role_web
}
