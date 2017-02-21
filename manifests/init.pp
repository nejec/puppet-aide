# Class: aide
# ===========================
#
# Full description of class aide here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'aide':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Luke Hinds <lhinds@protonmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Luke Hinds
#
class aide (
  $package_name = $::aide::params::package_name,
  $hour                   = $aide::params::hour,
  $minute               = $aide::params::minute,
  $email                  = $aide::params::email,
  $rules                   = {},
) inherits aide::params {

  package { 'aide':
      ensure => $::aide::version,
      name   => $package_name,
      alias  => 'aide',
  }

  contain 'aide::installdb'

  concat { 'aide.conf':
    path    => $::aide::conf_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    ensure_newline => true,
    require => Package['aide']
  }

  concat::fragment { 'aide.conf.header':
    target  => 'aide.conf',
    order   => 0,
    content => template( 'aide/aide.conf.erb')
  }

# If a hash of rules is supplied with class then call auditd::rules defined type to apply them
  if $rules {
    create_resources('::aide::rule', $rules)
  }

 contain 'aide::cron'

}
