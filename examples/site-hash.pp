class { '::aide':
  email  => 'root@localhost',
  hour => 3,
  minute => 0,
  rules => {
    'MyRule' => {
      content => 'MyRule = p+sha256',
      order   => 1,
    },
    'etc' => {
      content => '/etc MyRule',
      order   => 2,
    },
    'boot'  => {
      content => '/boot MyRule',
      order   => 3,
    },
  },
}
