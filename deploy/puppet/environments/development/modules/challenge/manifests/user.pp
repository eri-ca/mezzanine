# == Class: challenge::user
#
# Create required user, group and homedir for the Sanoma DevOps
# challenge.
#
# === Authors
#
# Robert Erica <r.c.erica@gmail.com>
#
# === Copyright
#
# Copyright 2014 Robert Erica
#
class challenge::user {

  $password = '$1$YbWYZ7xk$W7y.DE5Cf3KQCesytsHhQ.' # "devops"

  group { 'sanoma':
    ensure => present,
  } ->

  user { 'sanoma':
    ensure   => present,
    password => $password,
    gid      => 'sanoma',
    home     => '/home/sanoma',
  } ->

  file { '/home/sanoma':
    ensure => 'directory',
    owner  => 'sanoma',
    group  => 'sanoma',
    mode   => '0711',
  }
}
