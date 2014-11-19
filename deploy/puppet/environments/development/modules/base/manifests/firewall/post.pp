# Class base::firewall::post
#
# iptables filter rules to execute as last rules.
#
class base::firewall::post {

  firewall { '99999 reject all':
    proto  => 'all',
    action => 'reject',
    before => undef,
  }
  firewall { '99999 reject all in FORWARD chain':
    proto  => 'all',
    action => 'reject',
    before => undef,
    chain  => 'FORWARD',
  }

}
