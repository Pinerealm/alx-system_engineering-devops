# Set up SSH config file to connect to a server without a password.
file_line { 'config_no_password':
    ensure => 'present',
    path   => '/etc/ssh/ssh_config',
    line   => '    PasswordAuthentication no',
    match  => '#   PasswordAuthentication'
}

file_line { 'config_ssh_file':
    ensure => 'present',
    path   => '/etc/ssh/ssh_config',
    line   => '    IdentityFile ~/.ssh/school'
}
