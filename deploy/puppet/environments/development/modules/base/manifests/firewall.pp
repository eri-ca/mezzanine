# Class base::firewall
#
# Use Puppetlabs/firewall module to manage iptables.
#
class base::firewall (
  $rules = {}
) {

  resources { "firewall":
    purge => true
  }

  # Ensure corrent dependencies and ordering pre -> custom -> post
  Firewall {
    before  => Class['base::firewall::post'],
    require => Class['base::firewall::pre'],
  }

  class { ['base::firewall::pre', 'base::firewall::post']: }

  firewall { '022 Allow SSH from the world':
    action => 'accept',
    port   => '22',
    proto  => 'tcp',
  }

  firewall { '001 Allow all ICMP':
    action => 'accept',
    proto  => 'icmp',
  }

  # Create firewall rules from Hiera config
  create_resources('firewall', $rules)

}
