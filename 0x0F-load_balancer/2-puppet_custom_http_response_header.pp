# Install and configure an nginx web server.

# 1. Update the apt package index
exec { 'apt-get update':
  command => 'apt-get update',
  path    => '/usr/bin',
}

# 2. Install nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['apt-get update'],
}

# 3. Change ownership of some nginx directories
file { '/var/www':
  ensure  => 'directory',
  owner   => $id,
  group   => $gid,
  recurse => true,
  require => Package['nginx'],
}

file { '/usr/share/nginx/html':
  ensure  => 'directory',
  owner   => $id,
  group   => $gid,
  recurse => true,
  require => Package['nginx'],
}

# 4. Create custom home and 404 pages
file { 'index.html':
  ensure  => 'file',
  path    => '/var/www/html/index.html',
  content => "Hello World!\n",
  require => File['/var/www'],
}

file { 'custom_404.html':
  ensure  => 'file',
  path    => '/usr/share/nginx/html/custom_404.html',
  content => "Ceci n\'est pas une page\n",
  require => File['/usr/share/nginx/html'],
}

# 5. Modify the default nginx configuration file

$context = "\tadd_header X-Served-By \$hostname always;"
$file = '/etc/nginx/nginx.conf'

exec { 'modify_nginx_config':
  command => "sudo sed -i '/sendfile/i\\ ${context}' ${file}",
  path    => '/usr/bin:/bin',
  unless  => "grep -q 'add_header X-Served-By' ${file}",
  require => Package['nginx'],
}

# 6. Start nginx
service { 'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}

# 7. Reload nginx
exec { 'reload_nginx':
  command => 'nginx -s reload',
  path    => '/usr/bin:/usr/sbin',
  require => [Service['nginx'], Exec['modify_nginx_config']],
}
