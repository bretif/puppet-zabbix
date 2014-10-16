# == Class: zabbix::scripts::apache
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
class zabbix::scripts::apache_check () {
  
  # Controlling the 'apache2' service
  service { 'apache2':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
  
  file { "/etc/zabbix/scripts":
                owner   => "zabbix",
                group   => "zabbix",
                mode    => 0755,
                ensure  => [directory, present],
        }

  file { '/etc/zabbix/scripts/apache-check.sh':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0750',
    replace => true,
    source  => "puppet:///modules/zabbix/apache-check.sh",
  }

  file { '/etc/zabbix/zabbix_agentd.d/apache-params.conf':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0750',
    replace => true,
    source  => "puppet:///modules/zabbix/apache-params.conf", 
  }
  
  # Nginx vhost to activate apache status page
  file { '/etc/apache2/sites-available/apache_status.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['apache2'],
    content => template('zabbix/apache_status.conf.erb'),
  }
 
  file { '/etc/apache2/sites-enabled/apache_status.conf':
   ensure => 'link',
   target => '/etc/apache2/sites-available/apache_status.conf',
  } 
}