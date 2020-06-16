node 'puppetserver' {
  include mypuppet::puppetserver
}

node 'puppetdashboard' {
  include mypuppet::puppetdash
}
