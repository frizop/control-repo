# Class: profile::dotnet
# Params: 
# 
class profile::dotnet (

  String $dotnet_wanted_version = pick($::puppet_vra_property.dig('foo.dotnetversion'), '4.6.2'),
  String $windowssource         = 'C:\\vagrant\\files\\sxs'

) {

  notify { 'dotnet_installed_version': 
    message => '$::dotnet_installed_version',
  }

  # class to install dotnet_wanted_version
  if $dotnet_wanted_version == '3.5' and $::dotnet_installed_version != '3.5' {

    windowsfeature { 'NET-Framework-Features':
      ensure => present,
      source => $windowssource,
    }

    windowsfeature { 'NET-Framework-Core':
      ensure  => present,
      source  => $windowssource,
      require => Windowsfeature['NET-Framework-Features'],
    }

    windowsfeature { 'NET-HTTP-Activation':
      ensure  => present,
      source  => $windowssource,
      require => Windowsfeature['NET-Framework-Core'],
    }

    windowsfeature { 'NET-Non-HTTP-Activ':
      ensure  => present,
      source  => $windowssource,
      require => Windowsfeature['NET-HTTP-Activation'],
    }

  } elsif $::dotnet_installed_version != $dotnet_wanted_version {

    exec { "install-dotnet${dotnet_wanted_version}":
      command  => "Start-Process -Wait -FilePath $windowssource\\${dotnet_wanted_version}.exe -ArgumentList /q, /norestart",
      provider => powershell,
    }

    # dotnet 4+ _should_ set a pending reboot in the registry:
    reboot { 'check-pending':
      when => pending,
    }

  }

}