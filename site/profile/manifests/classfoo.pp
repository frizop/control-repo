# Class: profile::classfoo
#
#
class profile::classfoo {
    file { '/tmp/foo':
        ensure => file,
    }
}