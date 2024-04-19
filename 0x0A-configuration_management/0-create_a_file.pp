# creates a file in /tmp

file {'school':
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0744',
  content => 'I love puppet',
  path     => '/tmp/school'
}
