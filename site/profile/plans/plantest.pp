plan profile::plantest (
  String[1] $key, 
  String[1] $value,
) {
  run_task('profile::write_fact', key => $key, value => $value)
  run_task('profile::write_fact', key => $key, value => $value)
}
