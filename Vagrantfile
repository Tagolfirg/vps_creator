# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get -y install  curl
    SHELL
    config.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = ['config/chef/site-cookbooks', 'config/chef/cookbooks']
      chef.add_recipe "worldmaker"
      chef.add_recipe "worldmaker::users"
      # chef.add_recipe "worldmaker::ssh"
      chef.add_recipe "worldmaker::nodejs"
      chef.add_recipe "worldmaker::postgres"
      chef.add_recipe "worldmaker::rbenv"
      chef.add_recipe "worldmaker::redis"
      chef.add_recipe "worldmaker::nginx"
      chef.add_recipe "worldmaker::app"
      chef.json = {
        group: "makers",
        port: 2222,
      
        user: {
           name: "jet",
           password: "$1$xyz$1Wk6nMAPrS/YYWT/vvG6x/"
        },
      
        db: {
             root_password: "goeagles67",
             user: {
                name: "jet",
                password: "turtleisland49"
             }
          }
      }

    end
end
