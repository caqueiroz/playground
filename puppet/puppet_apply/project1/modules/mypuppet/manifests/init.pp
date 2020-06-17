class mypuppet {

  $packages = ['git', 'ruby']
  package{ $packages:
    ensure  => 'installed',
  }

}
