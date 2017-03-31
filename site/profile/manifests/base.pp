# stuff
class profile::base {
  exec { 'test':
    command  => '[System.Console]::Error.WriteLine("foo")',
    provider => powershell,
  }

  iis_site { 'Default Web Site':
    ensure   => 'started',
    app_pool => 'DefaultAppPool',
    ip       => '*',
    path     => 'C:\InetPub\WWWRoot',
    port     => '80',
    protocol => 'http',
    ssl      => false,
  }

}
