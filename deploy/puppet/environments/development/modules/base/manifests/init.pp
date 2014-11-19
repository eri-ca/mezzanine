# == Class: base
#
# Base class runs basic configuration of a CentOS/RHEL (v)box.
#
# === Authors
#
# Robert Erica <r.c.erica@gmail.com>
#
# === Copyright
#
# Copyright 2014 Robert Erica
#
class base {

  include base::firewall

  host { "$::hostname.$::domain":
    ip           => $::ipaddress,
    host_aliases => [$::hostname]
  }

}
