# == Class: challenge
#
# Full description of class challenge here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { challenge:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class challenge::wsgi_server {

  $challenge_docroot = '/home/sanoma/devopschallenge'

  firewall { '080 Allow All on HTTP/80':
    action => 'accept',
    proto  => 'tcp',
    port   => '80',
  } ->

  #  class { 'apache': }
  class { 'apache':
    default_mods        => false,
    default_confd_files => false,
  }

  class { 'apache::mod::wsgi':
    wsgi_socket_prefix => "\${APACHE_RUN_DIR}WSGI",
  }

  apache::vhost { 'sanoma.local':
    priority                    => '10',
    servername                  => 'sanoma.local',
    port                        => 80,
    docroot                     => "${challenge_docroot}/",
    wsgi_application_group      => '%{GLOBAL}',
    wsgi_daemon_process         => 'sanoma.local',
    wsgi_daemon_process_options => {
      processes   => '2',
      threads     => '15',
      user        => 'sanoma',
      group       => 'sanoma',
      python-path => "/home/sanoma:${challenge_docroot}",
    },
    wsgi_process_group          => 'sanoma.local',
    wsgi_script_aliases         => {
      '/' => "${challenge_docroot}/wsgi.py",
    },
    aliases                     => [
    {
      alias => '/static/',
      path  => "${challenge_docroot}/static/",
    }, {
      alias => '/robots.txt',
      path  => "${challenge_docroot}/static/robots.txt",
    },
    ],
  }
}
