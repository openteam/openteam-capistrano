require 'net/ssh/proxy/command'

server fetch('domain'),
  ssh_options: {
    proxy: Net::SSH::Proxy::Command.new("ssh #{fetch('gateway')} -W %h:%p")
  }
