# Change the OS configuration so that it is possible to login with the holberton user and open a file without any error message.

exec { 'create_holberton_user':
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  command => '/bin/chown -R holberton:holberton /etc/nginx'
}
