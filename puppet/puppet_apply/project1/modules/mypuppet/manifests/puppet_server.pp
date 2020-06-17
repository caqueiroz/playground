class mypuppet::puppet_server inherits mypuppet {
  $master_cert_name = hiera('mypuppet::puppetserver::master_cert_name')
#  $master_cert_name = 'puppetmaster.queiroz.car'

  class {'puppetserver':
    config  => {
      'java_args' => {
        'xms'         => '1g',
        'xmx'         => '1g',
        'maxpermsize' => '256m',
        'tmpdir'      => '/tmp',
      },
      'webserver' => {
        'ssl-port'  => '8140',
        'ssl-host'  => '0.0.0.0',
        'host'      => '0.0.0.0',
        'port'      => '8141'
      }
    },
    manage_service    => 'false'
  }

  file {'/etc/puppetlabs/puppet/puppet.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content  => template('mypuppet/mypuppet/puppet.conf.erb'),
    require  => Class['puppetserver::install'],
  }

  file {'/etc/puppetlabs/puppetserver/conf.d/master.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content  => template('mypuppet/mypuppet/master.conf.erb'),
    require  => Class['puppetserver::install']
  }
  #file {'/etc/puppetlabs/code/environments/production/manifests/site.pp':
  #  ensure  => 'file',
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  content  => template('mypuppet/mypuppet/site.pp.erb'),
  #  require  => Class['puppetserver::install']
  #}
  vcsrepo {'/opt/nodeclassifier':
    ensure    => 'present',
    provider  => 'git',
    source    => 'ssh://gituser@<host>.caqueiroz.com/home/gituser/GITREPO/nodeclassifier',
  }
  vcsrepo {'/etc/puppetlabs/code/environments/production':
    ensure    => 'present',
    force     => 'true',
    provider  => 'git',
    source    => 'ssh://gituser@<host>.caqueiroz.com/home/gituser/GITREPO/puppetcode/prod',
  }
}
