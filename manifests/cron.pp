# Conifigures cron and installs mailx is `email` parameter is defined
class aide::cron inherits aide {
    if $::aide::email {
      $cron_entry = "${aide::command} --check ${aide::check_parameters} | ${aide::mail_path} -s \"\$HOSTNAME - Daily AIDE integrity check\" ${aide::email}"
        package { 'mailx':
          ensure => installed,
        }
      }
      else {
        $cron_entry = "${aide::command} --check ${aide::check_parameters} > /var/log/audit/aide_`date +%Y-%m-%d`.log"
      }
      cron { 'aide':
        ensure  => $::aide::ensure_cron,
        command => $cron_entry,
        user    => 'root',
        hour    => $::aide::hour,
        minute  => $::aide::minute,
        require => [Package['aide'], Exec['install aide db']]
      }
    }
