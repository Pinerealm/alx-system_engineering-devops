# Configure Nginx to eliminate failed requests due to
# 'Too many open files' errror
exec { 'Increase open files limit':
    command => 'sed -i s/15/4096 /etc/default/nginx',
    path    => '/bin',
}

# Restart Nginx
exec { 'nginx-restart':
  command => 'nginx restart',
  path    => '/etc/init.d/'
}
