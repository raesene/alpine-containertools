#!/usr/bin/env ruby

require 'resolv'

resolver = Resolv::DNS.new

results = resolver.getresources("any.any.svc.cluster.local",Resolv::DNS::Resource::IN::SRV)

ports = Array.new
hosts = Array.new

puts "Services and ports running in this cluster"
puts "------------------------------------------"
results.each do |result|
  ports.push(result.port)
  hosts.push(result.target.to_s)
  name = result.target.to_s.split(".")[0]
  namesapce = result.target.to_s.split(".")[1]
  puts "Service: #{name} in namespace: #{namesapce} on port: #{result.port.to_s}"
end

ports.uniq!
hosts.uniq!

puts "\n\n\nnmap command to scan the cluster network"
puts "----------------------------------------------"
puts "nmap -sTVC -v -n -p #{ports.join(',')} #{hosts.join(' ')}"