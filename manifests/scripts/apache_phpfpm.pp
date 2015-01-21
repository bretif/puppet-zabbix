# == Class: zabbix::scripts::apache_phpfpm
#
#  This will install apache script used to monitor apache
#
# === Authors
#
# Author Name: bretif@phosphore.eu
#
# === Copyright
#
# Copyright 2014 Bertrand RETIF
#
class zabbix::scripts::apache_phpfpm () {
  
  file { '/etc/zabbix/scripts/phpfpm-check.sh':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0750',
    replace => true,
    source  => "puppet:///modules/zabbix/phpfpm-check.sh",
  }

  file { '/etc/zabbix/zabbix_agentd.d/phpfpm-params.conf':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0664',
    replace => true,
    source  => "puppet:///modules/zabbix/phpfpm-params.conf", 
  }
  
  # Vhost to activate php-fpm status page on specific port
  file { '/etc/apache2/sites-available/apache_phpfpm_status.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['apache2'],
    content => template('zabbix/apache_phpfpm_status.conf.erb'),
  }
 
  file { '/etc/apache2/sites-enabled/apache_phpfpm_status.conf':
   ensure => 'link',
   target => '/etc/apache2/sites-available/apache_phpfpm_status.conf',
  } 
}