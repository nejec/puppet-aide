include '::aide'

aide::rule { 'watch for updates to users':
  content => '-w /etc/passwd -p wa -k identity',
  order   => 1,
}
aide::rule { 'audit for time changes':
  content => '-a always,exit -S clock_settime -k time-change',
  order   => 2,
}
aide::rule { '-a always,exit -S sethostname -S setdomainname -k system-locale':
  order   => 3,
}
