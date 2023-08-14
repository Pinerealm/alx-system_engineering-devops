# Correct an Apache2 webserver 500 status error
file { 'locale.phpp':
  path   => '/var/www/html/wp-includes/class-wp-locale.phpp',
  ensure => present,
  source => '/var/www/html/wp-includes/class-wp-locale.php',
}
