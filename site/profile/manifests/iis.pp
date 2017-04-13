# profile::iis
# profile to install iis on windows server
# the profile is based on simondean/iis
#
class profile::iis (

  $appname = 'Default Web Site',
  $foo = pick($::puppet_vra_properties['something'], 'some_value')

  ){

  notice { $foo: }

  file { 'c:\\tmp':
    ensure => directory,
  }

  $iis_features = ['Web-Server',
    'Web-WebServer',
    'Web-Asp-Net45',
    'Web-ISAPI-Ext',
    'Web-ISAPI-Filter',
    'NET-Framework-45-ASPNET',
    'Web-Http-Redirect',
    'Web-Filtering',
    'Web-Mgmt-Console',
    'Web-Mgmt-Tools',
  ]

  windowsfeature { $iis_features:
    ensure  => present,
  }

  iis_apppool { $appname:
    ensure                => 'present',
    managedpipelinemode   => 'Integrated',
    managedruntimeversion => 'v4.0',
  }

  iis_site { $appname:
    ensure   => present,
    require  => Windowsfeature['Web-Server'],
    bindings => ['http/*:80:'],
  }

  iis_app { "$appname/":
    ensure          => present,
    applicationpool => $appname,
  }

  iis_vdir { "$appname/":
    ensure       => 'present',
    iis_app      => "$appname/",
    physicalpath => 'C:\\tmp',
    require      => File['c:\\tmp'],
  }

}