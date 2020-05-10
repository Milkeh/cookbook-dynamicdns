#
# Cookbook:: cookbook-dynamicdns
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

script_dir = '/opt/hmckenzie-scripts/'

directory script_dir do
  owner 'ubuntu'
  group 'ubuntu'
  recursive true
end

file '/opt/hmckenzie-scripts/domain.config' do
  content 'DOMAIN=hmckenzie.net
ZONE_ID=Z1AX8SJYOXCIX6'
  owner 'ubuntu'
  group 'ubuntu'
end

cron_d 'dynamic-dns' do
    action :create
    minute '*/5'
    command '/opt/hmckenzie-scripts/dynamic-dns.sh | tee -a /var/log/dynamic-dns.log'
  end