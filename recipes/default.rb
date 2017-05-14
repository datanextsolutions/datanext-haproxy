#
# Cookbook:: datanext-haproxy
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# This is practice cookbook by Zee

all_web_nodes = search('node',"role:web AND chef_environment:#{node.chef_environment}")

members = []

all_web_nodes.each do |web_node|

#  ip = web_node[:network][:interfaces][:eth0][:addresses].detect{|k,v| v[:family] == "inet" }.first
#  remote_ip = ip.gsub /\.\d+$/, '.1'

  member = {
  	'hostname'  => web_node['hostname'],
  	'ipaddress' => web_node['ipaddress'],
  	'port' => 80,
  	'ssl_port' => 80
  }

  members.push(member)

end

node.default['haproxy']['members'] = members

include_recipe "haproxy::manual"
