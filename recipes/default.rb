#
# Cookbook:: cookbook-dynamicdns
# Recipe:: default
#
# Copyright:: 2020, Harley McKenzie, All Rights Reserved.

script_dir = '/opt/hmckenzie-scripts/'
config_dir = '/etc/dynamic-dns/'

package 'jq'

git script_dir do
  repository 'git://github.com/Milkeh/hmckenzie-scripts.git'
  revision 'dev'
  action :checkout
end

directory config_dir do
  recursive true
end

cookbook_file '/etc/dynamic-dns/domain.config' do
  source 'domain.config'
end

cron_d 'dynamic-dns' do
  action :create
  minute '*/5'
  command '/opt/hmckenzie-scripts/dynamic-dns.sh | tee -a /var/log/dynamic-dns.log'
end