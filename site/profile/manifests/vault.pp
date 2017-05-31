# Class: profile::vault
#
#
class profile::vault {

  if $::facts['osfamily'] != 'windows' {
    package { 'wget':
      ensure => present,
    }

    package { 'bunzip':
      ensure => present,
    }

    Archive {
      provider => 'wget',
      require  => Package['wget', 'bunzip'],
    }
  }
  
  include vault
}