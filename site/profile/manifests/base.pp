# stuff
class profile::base {
  exec { 'test':
    command  => '[System.Console]::Error.WriteLine("foo")',
    provider => powershell,
  }

  $iis_features = ['Web-WebServer','Web-Scripting-Tools']

  iis_feature { $iis_features:
    ensure => present,
  } ->

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    applicationpool => 'DefaultApplicationPool',
  }

}
