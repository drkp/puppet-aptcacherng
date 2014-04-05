# TODO document
class aptcacherng::params {
  case $::osfamily {
    # covers debian and ubuntu, which is all we support
    'debian' : {
      $package = 'apt-cacher-ng'
    }
    default: {
      fail ("aptcacherng: ${::osfamily} not supported.")
    }
  }
}
