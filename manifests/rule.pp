##  params:
##    content: Rule definition
##    order:   Relative order of this rule

define aide::rule($content='', $order=10) {
  if $content == '' {
    $body = $name
  } else {
    $body = $content
  }

  if (!is_numeric($order) and !is_string($order))
  {
    fail('$order must be a string or an integer')
  }
  validate_string($body)

  concat::fragment{ "aide_fragment_${name}":
    target  => 'aide.conf',
    order   => $order,
    content => $body,
  }
}
