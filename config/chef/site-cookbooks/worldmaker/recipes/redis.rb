package "tcl8.5"

#download redis
remote_file "/home/#{node['user']['name']}/redis-#{node['redis']['version']}.tar.gz" do
  source "http://download.redis.io/releases/redis-#{node['redis']['version']}.tar.gz"
  mode 0644
  action :create_if_missing
end

# install redis
bash 'install redis' do
  cwd "/home/#{node['user']['name']}"
  code <<-EOH
    tar xzf redis-#{node['redis']['version']}.tar.gz
    cd redis-#{node['redis']['version']}
    make && make install
  EOH
  not_if { File.exists?("/usr/local/bin/redis-server") &&
  `redis-server --version`.chomp.split[2] == "v=#{node['redis']['version']}" }
end

# install redis server


cookbook_file "redis_server_installer.sh" do
  source "redis_server_installer.sh"
  mode 0755
end

# jet below has not been tested, 20May2015
execute "Install redis server" do
  command "sh redis_server_installer.sh"
  cwd "/home/#{node['user']['name']}/redis-#{node['redis']['version']}/utils"
  not_if "ls /etc/init.d | grep redis"
end

# jet Below was working, but commented out to test above
execute "curl -L https://gist.githubusercontent.com/vladigleba/28f4f6b4454947c5223e/raw | sh" do
  cwd "/home/#{node['user']['name']}/redis-#{node['redis']['version']}/utils"
  not_if "ls /etc/init.d | grep redis"
end
