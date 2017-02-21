class aide::cron inherits aide {
  if $::aide::email {
    package { 'mailx':
      ensure => installed,
  }
 }
  cron { 'aide':
    command => "${aide::command} --check ${aide::check_parameters} | ${aide::mail_path} -s \"\$HOSTNAME - Daily AIDE integrity check\" ${aide::email}",
    user    => 'root',
    hour    => $::aide::hour,
    minute  => $::aide::minute,
    require => [Package['aide'], Exec['install aide db']]
  }
}
