# Correct an Apache2 webserver 500 status error
file { '/var/www/html/wp-includes/class-wp-locale.phpp':
  ensure => 'file',
  source => '/var/www/html/wp-includes/class-wp-locale.php',
}
