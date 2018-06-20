# Class: profile::classfoo
#
#
class profile::classfoo {
    file { '/tmp/foo':
        ensure => file,
        content => 'this is the content of the file foo'
    }
}