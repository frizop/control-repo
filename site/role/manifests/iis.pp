# Class: role::iis
#
#
class role::iis {
  include profile::iis
  include profile::dotnet462
}