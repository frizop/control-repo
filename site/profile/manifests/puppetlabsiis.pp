# Class: profile::puppetlabsiis
#
#
class profile::puppetlabsiis {
  # $iis_features = ['Web-WebServer','Web-Scripting-Tools']

  # iis_feature { $iis_features:
  #   ensure => present,
  # } ->

  iis_site { 'minimal':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\minimal',
    applicationpool => 'DefaultApplicationPool',
  }

}