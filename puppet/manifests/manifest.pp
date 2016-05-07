# Puppet configuration

# Base

class base {

  # Update apt-get
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }
}

# Apache

class install_apache {

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  define apache::loadmodule () {
    exec { "/usr/sbin/a2enmod $name" :
      unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
      notify => Service[apache2]
    }
  }

  apache::loadmodule{"rewrite":}

}

# PHP

class install_php {

  package { "php5":
    ensure => present,
  }

  package { "php5-cli":
    ensure => present,
  }

  package { "php5-xdebug":
    ensure => present,
  }

  package { "php5-mysql":
    ensure => present,
  }

  package { "php5-imagick":
    ensure => present,
  }

  package { "php5-mcrypt":
    ensure => present,
  }

  package { "php-pear":
    ensure => present,
  }

  package { "php5-dev":
    ensure => present,
  }

  package { "php5-curl":
    ensure => present,
  }

  package { "php5-sqlite":
    ensure => present,
  }

  package { "libapache2-mod-php5":
    ensure => present,
  }

}

# MySQL

class install_mysql {

  package { "mysql-server":
    ensure => present,
  }

  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }

  package { "libmysqlclient-dev":
    ensure => present,
  }
}

# phpmyadmin

class install_phpmyadmin {
  package {
    "phpmyadmin":
      ensure => present,
      require => [
        Exec['apt-get update'],
        Package["php5", "php5-mysql", "apache2"],
      ]
  }

  file {
    "/etc/apache2/conf.d/phpmyadmin.conf":
      ensure => link,
      target => "/etc/phpmyadmin/apache.conf",
      require => Package['apache2'],
      notify => Service["apache2"]
  }
}

# PostgreSQL

class install_postgresql {

  package { "postgresql":
    ensure => present,
  }

  package { "pgadmin3":
    ensure => present,
  }

  package { "libpq-dev":
    ensure => present,
  }
}

# Packages

class install_packages {

  package { 'curl':
    ensure => present
  }

  package { 'build-essential':
    ensure => present
  }

  package { 'git-core':
    ensure => present
  }

  # Nokogiri dependencies.
  package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
    ensure => present
  }

  # ExecJS runtime.
  #package { 'nodejs':
  #  ensure => present
  #}

  package { 'vim':
    ensure => present
  }
}

# Includes

include base
include install_apache
include install_php
include install_mysql
include install_phpmyadmin
include install_postgresql
include install_packages