# creates a file in /tmp

file { 'school':
  ensure  => 'file',
  group   => 'www-data',
  mode    => '0744',
  owner   => 'www-data',
  content => 'I love puppet',
  path    => '/tmp/school'
}
