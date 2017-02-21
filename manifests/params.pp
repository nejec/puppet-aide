class aide::params {
 $db_path      = '/var/lib/aide/aide.db'
 $db_temp_path = '/var/lib/aide/aide.db.new.gz'
 case $::osfamily {
  'Debian': {
    $package_name       = 'aide'
    $version        = latest
    $aide_path = '/usr/bin/aide'
    $conf_path = '/etc/aide/aide.conf'
    }
  'RedHat': {
    $package_name       = 'aide'
    $version        = latest
     $aide_path = '/usr/sbin/aide'
     $conf_path = '/etc/aide.conf'
   }
  }
}
