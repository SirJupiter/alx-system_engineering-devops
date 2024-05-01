# automate the task of creating a custom HTTP header response, but with Puppet.
# The name of the custom HTTP header must be X-Served-By
# The value of the custom HTTP header must be the hostname of the server Nginx is running on
# Write 2-puppet_custom_http_response_header.pp so that it configures a brand new Ubuntu machine to the requirements asked in this task

# Update system
exec { 'update ubuntu system':
  command     => 'apt-get update',
}

# Install nginx
package { 'nginx':
  ensure => installed,
}

# Start nginx service
service { 'nginx':
  ensure => running,
  enable => true,
}

# Create index.html and add "Hello World!" to it
exec { 'create index.html':
  command  => 'echo "Hello World!" | /var/www/html/index.html',
}

# Add custom header to nginx configuration
$custom_header = "add_header X-Served-By ${hostname};"

# Insert custom header after 'server {' in nginx configuration
file_line { 'nginx_custom_header':
  path  => '/etc/nginx/sites-available/default',
  line  => $custom_header,
  match => 'server {',
}

# Create symbolic link to enable the configuration
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
}

# Test nginx configuration
exec { 'nginx_config_test':
  command     => 'nginx -t',
  path        => '/usr/sbin:/usr/bin:/sbin:/bin',
  logoutput   => true,
  refreshonly => true,
}

# Restart nginx service if configuration is valid
service { 'nginx':
  ensure     => running,
  enable     => true,
  subscribe  => Exec['nginx_config_test'],
  hasrestart => true,
}
