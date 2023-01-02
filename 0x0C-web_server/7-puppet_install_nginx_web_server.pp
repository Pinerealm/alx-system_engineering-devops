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
  content => 'Hello World!\n',
  require => File['/var/www'],
}

file { 'custom_404.html':
  ensure  => 'file',
  path    => '/usr/share/nginx/html/custom_404.html',
  content => 'Ceci n\'est pas une page\n',
  require => File['/usr/share/nginx/html'],
}

# 5. Modify the default nginx configuration file

# $context = "\tlocation /redirect_me {\n\t\treturn 301 \
# https://www.youtube.com/watch?v=QH2-TGUlwu4;\n\t}\n"
# $file = '/etc/nginx/sites-enabled/default'

# exec { 'modify_nginx_config':
#   command => "sudo sed -i '/pass PHP scripts/i\\ ${context}' ${file}",
#   path    => '/usr/bin:/bin',
#   unless  => "grep -q 'location /redirect_me' ${file}",
#   require => Package['nginx'],
# }

file { 'nginx_config':
  ensure  => 'file',
  path    => '/etc/nginx/sites-enabled/default',
  content =>
  "server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files \$uri \$uri/ =404;
	}
 
 	location /redirect_me {
		return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
	}

 	error_page 404 /custom_404.html;
	location = /custom_404.html {
		root /usr/share/nginx/html;
		internal;
	}

}",
  backup  => false,
  require => Package['nginx'],
}

# 6. Start nginx
service { 'nginx':
  ensure  => 'running',
  restart => 'nginx -s reload',
  require => [Package['nginx'], File['nginx_config']],
}
