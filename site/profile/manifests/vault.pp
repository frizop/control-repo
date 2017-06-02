# Class: profile::vault
#
#
class profile::vault {

  if $::facts['osfamily'] != 'windows' {
    package { 'wget':
      ensure => present,
    }

    package { 'unzip':
      ensure => present,
    }

    Archive {
      provider => 'wget',
      require  => Package['wget', 'unzip'],
    }
  }
  
  include vault
}