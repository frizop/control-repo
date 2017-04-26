# Class: profile::dotnet462
#
#
class profile::dotnet462 {

  if $::dotnet_version != '4.6.2' {

    exec { 'install-dotnet462':
      command  => 'Start-Process -Wait -FilePath C:\\vagrant\\files\\NDP462-KB3151800-x86-x64-AllOS-ENU.exe -ArgumentList /q, /norestart',
      provider => powershell,
      notify   => Reboot['check-pending'],
    }

    reboot { 'check-pending':
      apply => finished,
    }

  }

}