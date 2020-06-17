class mypuppet::lb {
  $packages = ['httpd', 'mod_ssl']
  $balanced_worker = hiera('mypuppet::lb::worker_members')
  $balanced_ca = hiera('mypuppet::lb::puppetca_members')
  $non_ssl_port = hiera('mypuppet::puppetserver::non_ssl_port')
  $master_cert_name = hiera('mypuppet::puppetserver::master_cert_name')
  $master_hostname = hiera('mypuppet::puppetserver::master_hostname')

  package { $packages:
    ensure  => 'installed',
    before  => File['/etc/httpd/conf.d/lb.conf']
  }

  file { '/etc/httpd/conf.d/lb.conf':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0750',
    content   => template('mypuppet/mypuppet/lb.conf.erb'),
    }

  firewalld_port { 'Open port 8140 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => 8140,
    protocol => 'tcp',
    require   => File['/etc/httpd/conf.d/lb.conf']
  }

  selinux::boolean { 'httpd_can_network_connect': }

  service { 'httpd':
    provider => systemd,
    enable => true,
    require => Package['httpd']
  }



}
