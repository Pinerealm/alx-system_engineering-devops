# Install and configure an nginx web server.

# Update the apt package index
exec { 'apt-get update':
  command => ' sudo apt-get update',
  path    => '/usr/bin',
}

# Install nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['apt-get update'],
}

# Modify the default nginx configuration file
$context = "\tadd_header X-Served-By \$hostname always;"
$file = '/etc/nginx/nginx.conf'

exec { 'modify_nginx_config':
  command => "sudo sed -i '/sendfile/i\\ ${context}' ${file}",
  path    => '/usr/bin:/bin:/usr/sbin:/sbin',
  unless  => "grep -q 'add_header X-Served-By' ${file}",
  require => Package['nginx'],
}

# Restart nginx
exec { 'restart_nginx':
  command => 'sudo service nginx restart',
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
  require => [Exec['modify_nginx_config'], Package['nginx']],
}
