#
# Copyright Alvaro Saurin <alvaro.saurin@gmail.com> - 2014
#

################################################################################################

class nodes::apache ($version = 'latest') {

    $APACHE = $operatingsystem ? {
      centos        => "httpd",
      redhat        => "httpd",
      default       => "apache2"
    }

    package {'apache':
      name   => $APACHE,
      ensure => $version,
    }
}
