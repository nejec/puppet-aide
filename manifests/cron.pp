class aide::cron inherits aide {
   if $::aide::email {
     $command = "${aide::command} --check ${aide::check_parameters} | ${aide::mail_path} -s \"\$HOSTNAME - Daily AIDE integrity check\" ${aide::email}"
     package { 'mailx':
         ensure => installed,
       }
   }
   else {
     $command = "${aide::command} --check ${aide::check_parameters} > /var/log/audit/aide_`date +%Y-%m-%d`.log"
   }
   cron { 'aide':
      command => $command,
      user    => 'root',
      hour    => $::aide::hour,
      minute  => $::aide::minute,
      require => [Package['aide'], Exec['install aide db']]
   }
}
