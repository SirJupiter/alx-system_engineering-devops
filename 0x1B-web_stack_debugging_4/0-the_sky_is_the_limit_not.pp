# we are using ApacheBench which is a quite popular tool in the industry. It allows you to simulate HTTP requests to a web server. In this case, I will make 2000 requests to my server with 100 requests at a time. We can see that 943 requests failed; this file should fix our stack so that we get to 0

exec { 'fix--for-nginx':
  command => '/bin/sed -i "s/worker_connections [0-9]*/worker_connections 1024/" /etc/nginx/nginx.conf && /bin/sed -i "s/worker_processes [0-9]*/worker_processes auto/" /etc/nginx/nginx.conf && nginx -s reload',
  path    => ['/bin', '/usr/bin'],
  onlyif  => 'grep -q "worker_connections" /etc/nginx/nginx.conf',
}

# Ensure the Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Exec['fix--for-nginx'],
}

