# setup sslh
#
# hosts: a hash of ipaddress   => portnumber
# protocols: a hash of service => ipaddressORhostname:portnumber
#
class sslh(
  $hosts     = { $ipaddress => '443' },
  $protocols = {
    ssh     => 'localhost:22',
    ssl     => 'localhost:443',
    anyprot => 'localhost:443',
  },
){

  package{'sslh':
    ensure => installed,
  } -> file{'/etc/sslh.cfg':
    content => template('sslh/sslh.cfg.erb'),
    owner   => 'root',
    group   => 0,
    mode    => '0644',
  } ~> service{'sslh':
    ensure => running,
    enable => true,
  }
}
