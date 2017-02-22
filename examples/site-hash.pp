class { '::aide':
  email  => 'root@localhost',
  hour => 3,
  minute => 0,
  rules => {
    'etc' => {
      content => '/etc p+md5',
      order   => 1,
    },
    'boot'  => {
      content => '/boot p+md5',
      order   => 2,
    },
  },
}
