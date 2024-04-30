# automate the task of creating a custom HTTP header response, but with Puppet.
# The name of the custom HTTP header must be X-Served-By
# The value of the custom HTTP header must be the hostname of the server Nginx is running on
# Write 2-puppet_custom_http_response_header.pp so that it configures a brand new Ubuntu machine to the requirements asked in this task

# Update system
exec { 'update ubuntu system':
  command     => '/usr/bin/sudo /usr/sbin/apt-get update',
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

# Directive for redirection
$redirect_directive = "location /redirect_me {
  return 301 https://www.youtube.com;
}"

# Append redirection directive to nginx configuration
file_line { 'nginx_redirect':
  path   => '/etc/nginx/sites-available/default',
  line   => $redirect_directive,
  before => 'server_name _;',
}

# Error page directive
$error_page_directive = "error_page 404 /page_error_404.html;
location = /page_error_404.html {
  root /usr/share/nginx/html;
  internal;
}"

# Append error page directive to nginx configuration
file_line { 'nginx_error_page':
  path  => '/etc/nginx/sites-available/default',
  line  => $error_page_directive,
  after => 'server_name _;',
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
