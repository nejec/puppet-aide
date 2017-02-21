node default {
  class { 'aide':
    email  => 'root@localhost',
    hour => 1,
}
  aide::rule { 'etc rule':
    content => '/etc p+sha256',
    order   => 1,
  }
  aide::rule { 'tmp rule':
    content => '/tmp p+sha256',
    order   => 2,
  }
}
