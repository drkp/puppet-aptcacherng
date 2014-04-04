# == Class: aptcacherng
#
# Applying `aptcacherng` to a node will configure the node to act as a
# caching proxy for apt (and other) package management systems.
#
# === Parameters
#
# [*cachedir*]
#   Change the default directory where apt-cacher-ng will store its cache.
#   Default: '/var/cache/apt-cacher-ng'
#
# === Examples
#
#  class { aptcacherng:
#    cachedir => '/data/apt-cache'
#  }
#
# === Authors
#
# Mark Hellewell <mark.hellewell@gmail.com>
#
# === Copyright
#
# Copyright 2013 Mark Hellewell.
#
class aptcacherng (
  $packagename = undef,
  $cachedir = '/var/cache/apt-cacher-ng',
  $logdir = '/var/log/apt-cacher-ng',
  $supportdir = undef,
  $port = '3142',
  $bindaddress = undef,
  $proxy = undef,
  $remap_lines = undef,
  $reportpage = 'acng-report.html',
  $socketpath = undef,
  $unbufferlogs = undef,
  $verboselog = undef,
  $foreground = undef,
  $pidfile = undef,
  $offlinemode = undef,
  $forcemanaged = undef,
  $extreshold = 4,
  $exabortonproblems = undef,
  $stupidfs = undef,
  $forwardbtssoap = undef,
  $dnscacheseconds = undef,
  $maxstandbyconthreads = undef,
  $maxconthreads = undef,
  $vfilepattern = undef,
  $pfilepattern = undef,
  $wfilepattern = undef,
  $debug = undef,
  $exposeorigin = undef,
  $logsubmittedorigin = undef,
  $useragent = undef,
  $recompbz2 = undef,
  $networktimeout = undef,
  $dontcacherequested = undef,
  $dontcacheresolved = undef,
  $dontcache = undef,
  $dirperms = undef,
  $fileperms = undef,
  $localdirs = undef,
  $precachefor = undef,
  $requestappendix = undef,
  $connectproto = undef,
  $keepextraversions = undef,
  $usewrap = undef,
  $freshindexmaxage = undef,
  $allowuserports = undef,
  $redirmax = undef,
  $vfileuserangeops = undef,
  $auth_username = undef,
  $auth_password = undef,
  # TODO support an argument for this
  # http://www.unix-ag.uni-kl.de/~bloch/acng/html/howtos.html#howto-importdisk
  ) {
  include aptcacherng::params

  # if a special alternative packagename was provided then use it,
  # otherwise use the package name determined by the params class.
  if $packagename {
    $package = $packagename
  } else {
    $package = $aptcacherng::params::package
  }

  package {'apt-cacher-ng':
    ensure => installed,
    name   => $package,
  }

  File {
    require => Package['apt-cacher-ng'],
    before  => Service['apt-cacher-ng'],
  }

  file {$cachedir:
    ensure  => directory,
    owner   => 'apt-cacher-ng',
    group   => 'apt-cacher-ng',
    mode    => '2755',
  }

  file {$logdir:
    ensure  => directory,
    owner   => 'apt-cacher-ng',
    group   => 'apt-cacher-ng',
    mode    => '2755',
  }

  file {'/etc/apt-cacher-ng/acng.conf':
    content => template('aptcacherng/acng.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['apt-cacher-ng'],
  }

  service {'apt-cacher-ng':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/apt-cacher-ng/acng.conf'],
  }

  if $auth_username {
    file {'/etc/apt-cacher-ng/security.conf':
      content => template('aptcacherng/security.conf.erb'),
      owner   => 'apt-cacher-ng',
      group   => 'apt-cacher-ng',
      mode    => '0600',
    }
  }

}
