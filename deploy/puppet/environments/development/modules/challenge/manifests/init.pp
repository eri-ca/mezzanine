# == Class: challenge
#
# Required resources for the Sanoma DevOps challenge
#
# === Authors
#
# Robert Erica <r.c.erica@gmail.com>
#
# === Copyright
#
# Copyright 2014 Robert Erica
#
class challenge {

  include challenge::user
  include challenge::python_pip_mezzanine
  include challenge::wsgi_server

}
