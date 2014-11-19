# Class base::firewall:pre
#
# iptable filter rules to execute as first rules.
#
class base::firewall::pre {

  Firewall {
    require => undef,
  }

  $my_interfaces = split($::interfaces, ',')

  define allow_own_interfaces {
    $my_ip = inline_template("<%= scope.lookupvar('::ipaddress_${title}') %>")
    
    firewall { "001 accept all traffic from ${title} to itself":
      proto       => 'all',
      source      => $my_ip,
      destination => $my_ip,
      iniface     => $title,
      action      => 'accept',
    }
  }

  # Default firewall rules
  firewall { '000 accept icmp type 3':
    proto  => 'icmp',
    action => 'accept',
    icmp   => 3,
  } ->

  firewall { '000 accept icmp type 8':
    proto  => 'icmp',
    action => 'accept',
    icmp   => 8,
  } ->

  # This solution is not pretty, but it works...
  # Allow all traffic to/from any IP on interface 'lo'
  firewall { '001 accept all traffic to lo on any IP':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  } ->

  firewall { '002 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }

  if $::is_virtual == 'true' {
    # This includes interface 'lo' (127.0.0.1) again...
    allow_own_interfaces { $my_interfaces:; }
  }
}

