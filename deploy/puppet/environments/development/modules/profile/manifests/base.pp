# == Class: profile::base
#
# Base profile module; to apply on all hosts
#
# === Authors
#
# Robert Erica <r.c.erica@gmail.com>
#
# === Copyright
#
# Copyright 2014 Robert Erica
#
class profile::base {

  include ::base
  include epel

}
