# Class: profile::puppetlabsiis
# i think largely this module is broken, even after pulling it from binford2k's issue branch
#
class profile::puppetlabsiis {
  $iis_features = ['Web-WebServer']

  iis_feature { $iis_features:
    ensure => present,
  } ->

  iis_application_pool { 'minimal_site_app_pool':
    ensure                  => 'present',
    managed_pipeline_mode   => 'Integrated',
    managed_runtime_version => 'v4.0',
    state                   => 'Started'
  } ->

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    applicationpool => 'minimal_site_app_pool',
  }

}