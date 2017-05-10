# Class: profile::puppetlabsiis
# i think largely this module is working, but only when pulling from git
#
class profile::puppetlabsiis (

  String $appname = pick($::puppet_vra_property.dig('foo.AppCode'), 'abc123'),

) {

  $iis_features = [
    'Web-Server',
    'Web-WebServer',
    'Web-Asp-Net45',
    'Web-ISAPI-Ext',
    'Web-ISAPI-Filter',
    'Web-Http-Redirect',
    'Web-Filtering',
    'Web-Mgmt-Console',
    'Web-Mgmt-Tools',
  ]

  iis_feature { $iis_features:
    ensure => present,
  }

  iis_application_pool { 'minimal_site_app_pool':
    ensure                  => 'present',
    managed_pipeline_mode   => 'Integrated',
    managed_runtime_version => 'v4.0',
    state                   => 'Started',
    require                 => Iis_feature['Web-WebServer'],
  }

  file { "c:\\inetpub\\${appname}":
    ensure => directory,
  }

  iis_site { $appname:
    ensure          => 'started',
    physicalpath    => "c:\\inetpub\\${appname}",
    applicationpool => 'minimal_site_app_pool',
    require         => [
      Iis_application_pool['minimal_site_app_pool'], 
      File["c:\\inetpub\\${appname}"],
    ],
  }

  iis_site { 'Default Web Site':
    ensure => 'absent',
  }

}