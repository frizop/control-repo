# Class: role::iis
#
#
class role::iis {
  include profile::puppetlabsiis
  include profile::dotnet
}