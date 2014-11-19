# == Class: challenge::python_pip_mezzanine
#
# Install Mezzanine and required packages (Some of which
# need a special version for the required version of
# Mezzanine to work).
#
# === Authors
#
# Robert Erica <r.c.erica@gmail.com>
#
# === Copyright
#
# Copyright 2014 Robert Erica
#
class challenge::python_pip_mezzanine {

  $project_name = 'devopschallenge'

  # Bleach in the most recent version is too new for the required version 
  # of Mezzanine... So we first install the second-to-last version.
  python::pip { 'bleach-1.2.2':
    pkgname => 'bleach',
    url     => 'https://github.com/jsocol/bleach/archive/v1.2.2.zip',
    owner   => 'root',
    timeout => 1800,
  } ->

  python::pip { 'future':
    pkgname => 'future',
    owner   => 'root',
    timeout => 1800,
  } ->

  python::pip { 'sanoma-nl_mezzanine' :
    pkgname => 'mezzanine',
    url     => 'https://github.com/sanoma-nl/mezzanine/archive/master.zip',
    owner   => 'root',
    timeout => 1800,
    before  => Class['apache'],
    } ->
  
  file { "/home/sanoma/${project_name}":
    ensure  => 'directory',
    owner   => 'sanoma',
    group   => 'sanoma',
    mode    => '0711',
    require => User['sanoma'],
  } ->

  exec { 'Create Mezzanine project':
    command => "mezzanine-project ${project_name}",
    cwd     => '/home/sanoma',
    path    => ['/usr/bin', '/usr/local/bin' ],
    creates => "/home/sanoma/${project_name}/manage.py",
    user    => 'sanoma',
  } ->

  exec { 'Create Mezzanine SQLite DB':
    command => 'python manage.py createdb --noinput',
    cwd     => "/home/sanoma/${project_name}",
    creates => "/home/sanoma/${project_name}/dev.db",
    path    => ['/usr/bin', '/usr/local/bin' ],
    user    => 'sanoma',
  } ->
  
  exec { 'Collect Mezzanine statics':
    command => 'python manage.py collectstatic --noinput',
    cwd     => "/home/sanoma/${project_name}",
    creates => "/home/sanoma/${project_name}/static/robots.txt",
    path    => ['/usr/bin', '/usr/local/bin' ],
    user    => 'sanoma',
  } ->

  file { "/home/sanoma/${project_name}/local_settings.py":
    ensure  => file,
    owner   => 'sanoma',
    group   => 'sanoma',
    mode    => '0644',
    content => template("${module_name}/mezzanine_local_settings.py.erb"),
  }
}
