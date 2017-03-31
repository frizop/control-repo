# stuff
class profile::base {
  exec { 'test':
    command  => '[System.Console]::Error.WriteLine("foo")',
    provider => powershell,
  }
}
