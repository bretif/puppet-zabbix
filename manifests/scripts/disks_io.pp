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
class zabbix::scripts::disks_io () {
 
  file { "/etc/zabbix/scripts":
                owner   => "zabbix",
                group   => "zabbix",
                mode    => 0755,
                ensure  => [directory, present],
        }

  file { '/etc/zabbix/scripts/lld-disks.py':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0750',
    replace => true,
    source  => "puppet:///modules/zabbix/lld-disks.py",
  }

  file { '/etc/zabbix/zabbix_agentd.d/userparameter_diskstats.conf':
    ensure  => present,
    owner   => 'zabbix',
    group   => 'zabbix',
    mode    => '0664',
    replace => true,
    source  => "puppet:///modules/zabbix/userparameter_diskstats.conf", 
  }
  
}