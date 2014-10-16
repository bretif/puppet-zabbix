# == Class: zabbix::scripts::backuppc
#
#  This will install backuppc script used to monitor nginx
#
# === Authors
#
# Author Name: bretif@phosphore.eu
#
# === Copyright
#
# Copyright 2014 Bertrand RETIF
#
class zabbix::scripts::nginx_check () {
  
  # Controlling the 'nginx' service
  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['nginx'],
  }
  
  file { "/etc/zabbix/scripts":
                owner   => "zabbix",
                group   => "zabbix",
                mode    => 0755,
                ensure  => [directory, present],
        }

  file { '/etc/zabbix/scripts/nginx-check.sh':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0750',
    replace => true,
    source  => "puppet:///modules/zabbix/nginx-check.sh",
    
  }
  
  # Nginx vhost to activate nginx status page
  file { '/etc/nginx/sites-available/nginx_status.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['nginx'],
    content => template('zabbix/nginx_status.conf.erb'),
  }
 
  file { '/etc/nginx/sites-enabled/nginx_status.conf':
   ensure => 'link',
   target => '/etc/nginx/sites-available/nginx_status.conf',
  }
  
}