# stuff
class profile::base {
  exec { 'test':
    command  => '[System.Console]::Error.WriteLine("foo")',
    provider => powershell,
  }

  $iis_features = ['Web-Server','Web-WebServer','Web-Asp-Net45','Web-ISAPI-Ext','Web-ISAPI-Filter','NET-Framework-45-ASPNET','WAS-NET-Environment','Web-Http-Redirect','Web-Filtering','Web-Mgmt-Console','Web-Mgmt-Tools']

  windowsfeature { $iis_features:
    ensure => present,
  }

  iis_site { 'Default Web Site':
    ensure   => 'started',
    app_pool => 'DefaultAppPool',
    ip       => '*',
    path     => 'C:\InetPub\WWWRoot',
    port     => '80',
    protocol => 'http',
    ssl      => false,
    require  => Windowsfeature['$iis_features'],
  }

}
