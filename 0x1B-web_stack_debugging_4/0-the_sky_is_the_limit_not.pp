# Configure Nginx to eliminate failed requests due to
# 'Too many open files' errror
exec { 'Increase open files limit':
    command => 'sed -i s/15/1024/ /etc/default/nginx',
    path    => '/bin',
}

# Restart Nginx
exec { 'Restart Nginx':
  command => 'sudo service nginx restart',
  path    => '/bin:/usr/bin:/sbin:/usr/sbin',
  require => Exec['Increase open files limit'],
}
