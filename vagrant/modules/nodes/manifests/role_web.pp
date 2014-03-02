#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::role_web {

	include '::python'
    include '::nodes::base'
    include '::nodes::mysql'
    include '::nodes::apache'

}
