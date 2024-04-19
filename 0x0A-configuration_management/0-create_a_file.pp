# creates a file in /tmp

file {'/tmp/school':
  ensure  => 'present',
  group   => 'www-data',
  mode    => '0744',
  owner   => 'www-data',
  content => 'I love puppet',
}
