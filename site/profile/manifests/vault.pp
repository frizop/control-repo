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
  
  class { '::vault':
    backend => {
      'file' => {
        'path' => '/tmp',
      }
    },
    listener => {
      'tcp' => {
        'address' => '0.0.0.0:8200',
        'tls_disable' => 1,
      }
    }
  }
}