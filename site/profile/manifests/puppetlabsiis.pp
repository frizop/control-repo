# Class: profile::puppetlabsiis
#
#
class profile::puppetlabsiis {
  $iis_features = ['Web-WebServer']

  iis_feature { $iis_features:
    ensure => present,
  } ->

  iis_application_pool { 'minimal_site_app_pool':
    ensure                => 'present',
    managedpipelinemode   => 'Integrated',
    managedruntimeversion => 'v4.0',
    state                 => 'Started'
  } ->

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    applicationpool => 'minimal_site_app_pool',
  }

}