# profile::iis
# profile to install iis on windows server
# the profile is based on simondean/iis
#
class profile::iis (

  String $appname = pick($::puppet_vra_property.dig('Albertsons.AppCode'), 'appname'),

  ) {

  notify { $appname: }

  file { 'c:\\tmp':
    ensure => directory,
  }

  $iis_features = [
    'Web-Server',
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
    require  => Iis_app['Default Web Site/'],
  }

  # We're going to remove the default web site, as it is already bound to port-80
  iis_app { 'Default Web Site/':
    ensure  => absent,
    require => Windowsfeature['Web-WebServer'],
  }

  iis_apppool { 'DefaultAppPool':
    ensure  => absent,
    require => Iis_app['Default Web Site/'],
  }

  iis_app { "${appname}/":
    ensure          => present,
    applicationpool => $appname,
    require         => Windowsfeature['Web-WebServer'],
  }

  iis_vdir { "${appname}/":
    ensure       => 'present',
    iis_app      => "${appname}/",
    physicalpath => 'C:\\tmp',
    require      => File['c:\\tmp'],
  }

}