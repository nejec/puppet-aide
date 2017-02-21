include '::aide'

aide::rule { 'etc rule':
  path => '/etc',
  rules => 'p+md5',
  order   => 1,
}
aide::rule { 'tmp rule':
  path => '/tmp',
  rules => 'p+md5',
  order   => 2,
}
