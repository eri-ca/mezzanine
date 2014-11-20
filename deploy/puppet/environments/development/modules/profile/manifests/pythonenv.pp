# Class profile::pythonenv
#
# Setup python.
#
class profile::pythonenv {

  class { 'python' :
    version    => 'system',
    pip        => true,
    dev        => true,
    virtualenv => true,
  }
}
