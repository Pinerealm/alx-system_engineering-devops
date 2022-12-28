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
  owner   => $facts['identity']['user'],
  group   => $facts['identity']['user'],
  recurse => true,
  require => Package['nginx'],
}

file { '/etc/nginx':
  ensure  => 'directory',
  owner   => $facts['identity']['user'],
  group   => $facts['identity']['user'],
  recurse => true,
  require => Package['nginx'],
}

file { '/usr/share/nginx':
  ensure  => 'directory',
  owner   => $facts['identity']['user'],
  group   => $facts['identity']['user'],
  recurse => true,
  require => Package['nginx'],
}

# 4. Create custom home and 404 pages
file { 'index.html':
  ensure  => 'file',
  path    => '/var/www/html/index.html',
  content => 'Hello, world!',
  require => File['/var/www'],
}

file { 'custom_404.html':
  ensure  => 'file',
  path    => '/usr/share/nginx/html/custom_404.html',
  content => 'Ceci n\'est pas une page',
  require => File['/usr/share/nginx'],
}

# 5. Modify the default nginx configuration file
# $context = 
# exec { 'sed default':
#   command => 'sed -i "/pass PHP scripts/ i\ $context" /etc/nginx/sites-enabled/default',

# }
# file { 'sites-enabled/default':
#   ensure  => 'file',
#   path    => '/etc/nginx/sites-enabled/default',
#   content => template('nginx/default.erb'),
#   require => File['/etc/nginx'],
# }

# 6. Start nginx
service { 'nginx':
  ensure  => 'running',
  require => Package['nginx'],
}
