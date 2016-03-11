# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'chef'
# require 'chef/config'
# require 'chef/knife'
Chef::Config.from_file(File.join(File.dirname(__FILE__), '.chef', 'knife.rb'))

VAGRANTFILE_API_VERSION = "2"
VM_BOX = "enemy-of-the-state/centos-7.1_kernel-devel-fixed"
Vagrant.require_version ">= 1.5.0"

my_nodes = [
  { name: 'application',   ip: '192.168.50.101', memory: 1024, ports: [
    { host: 3000, guest: 3000 },
    { host: 5432, guest: 5432 },
    { host: 6379, guest: 6379 }
    ]
  },
  { name: 'elasticsearch', ip: '192.168.50.102', memory: 1024, ports: [
    { host: 9200, guest: 9200 }
    ]
  },
  { name: 'kibana',        ip: '192.168.50.103', memory: 1024, ports: [] }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  my_nodes.each do |my_node|

    config.vm.define my_node[:name] do |config|
      if Vagrant.has_plugin?("vagrant-omnibus")
        config.omnibus.chef_version = "latest"
      end
      if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :machine
      end
      config.vm.box = VM_BOX
      config.vm.synced_folder ".", "/vagrant", disabled: true
      config.berkshelf.enabled = true
      config.vm.hostname = my_node[:name]
      config.vm.network :private_network, ip: my_node[:ip]
      my_node[:ports].each do |port|
        config.vm.network :forwarded_port, guest: port[:guest], host: port[:host]
      end
      config.vm.provider "virtualbox" do |vb|
        vb.memory = my_node[:memory]
      end
      # config.vm.provision :chef_solo do |chef|
      #   node = JSON.parse(IO.read("nodes/#{my_node[:name]}-#{my_node[:ip]}.json"))
      #   chef.run_list = node["run_list"]
      #   chef.log_level = "info"
      #   chef.node_name = "#{my_node[:name]}-#{my_node[:ip]}"
      #   chef.environments_path = "environments"
      #   chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
      #   chef.roles_path = "roles"
      #   chef.data_bags_path = "data_bags"
      #   chef.environment = "development"
      #   # chef.custom_config_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/.chef/knife.rb" # NEED TO SETUP
      #   # chef.encrypted_data_bag_secret_key_path # NEED TO SETUP
      #   # chef.provisioning_path # NEED TO SETUP
      # end

      config.vm.provision :chef_client do |chef|
        chef.chef_server_url = Chef::Config[:chef_server_url]
        chef.client_key_path = Chef::Config[:client_key]
        chef.validation_key_path = Chef::Config[:validation_key]
        chef.node_name = "#{my_node[:name]}-#{my_node[:ip]}"
        if Chef::Config[:encrypted_data_bag_secret]
          chef.encrypted_data_bag_secret = Chef::Config[:encrypted_data_bag_secret]
        end
        chef.environment = "development"
        chef.provisioning_path = "/etc/chef"
        chef.log_level = Chef::Config[:log_level]
      end
    end
  end
end
