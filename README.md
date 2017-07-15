# Puppet AIDE - Advanced Intrusion Detection Enviroment.

[![Build Status](https://travis-ci.org/lukehinds/puppet-aide.svg?branch=master)](https://travis-ci.org/lukehinds/puppet-aide)

#### Table of Contents

1. [Description](#description)
2. [Examples](#examples)
    * [Basic Rule Entry](#basic-rule-entry)
    * [Basic Rule using alias](#basic-rule-using-alias)
    * [Rules provided as a hash](#rules-provided-as-a-hash)
3. [Cron - CRON Entries](#cron)
4. [Hiera - Populating parameters using Hiera data](#heira)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#contributors)
7. [Credits](#Credits)

## Description

A Puppet module for the management of [AIDE - Advanced Intrusion Detection
Enviroment](http://aide.sourceforge.net/).

This module will install the AIDE package, populate rules into `aide.conf` and
initiate a new database.

A CRON job is created to allow a perodic run of
`aide --check` with the results logged to `/var/log/audit` or via an emailed
report.

If at any time, the rules parameters are changed, the module will re-initiate
the AIDE database to implement the new rules.

## Examples

### Basic Rule Entry

A series of rules can be passed to `aide.conf` by supplying each rule to the
`aide::rule` class:

    aide::rule { 'etc rule':
      content => '/etc p+sha256',
      order   => 1,
    }
    aide::rule { 'boot rule':
      content => '/boot p+sha256',
      order   => 2,
    }

The `order` denotes the sequence of rule placement within `aide.conf`

### Basic Rule using alias

Rules can be grouped under a common alias, to allow easy repetition:

    aide::rule { 'MyComplexRule':
      content => 'p+i+l+n+u+g+s+m+c+sha256',
      order   => 1,
    }
    aide::rule { 'boot':
      content => '/boot MyComplexRule',
      order   => 2,
    }
    aide::rule { 'etc ':
      content => '/etc MyComplexRule',
      order   => 3,
    }

Note: Custom rule declarations need to be placed at `order` 1.

### Rules provided as a hash

Rules can also be passed as a hash:

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
    }

More examples can be found in [aide/examples](https://github.com/lukehinds/puppet-aide/tree/master/examples)

## CRON

A cron entry is made using the parameters `hour`and `minute` and can be omitted setting the parameter `ensure_cron` to false.

If the parameter `email` is set, then `mailx` will be installed and an entry will be made to
crontab as follows:

    0 1 * * * /usr/sbin/aide --check --config=/etc/aide.conf | /bin/mail -s "$HOSTNAME - Daily AIDE integrity check" your_email@example.com

## HIERA

Values can be set using hiera, for example:

    aide::email: 'your_email@example.com'


## Limitations

Currently supports RedHat / CentOS 7 and Debian 8.

Currently travis build tests run against Puppet 4, but I have used this module
with no issues on Puppet 3.

## Contributors

Pull requests are welcome. Please ensure any code follows the Puppet Style
Guide and that new functionality is provided with unit tests when possible.

## Credits

Some of the design ideas are thanks to [Matt Lauber](https://github.com/mklauber).
This version is a refactor of his earlier module, but with hashes, spec tests,
cron, hiera and other features added.
