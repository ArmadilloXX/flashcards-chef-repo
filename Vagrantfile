# -*- mode: ruby -*-
# vi: set ft=ruby :

# require 'chef'
# require 'chef/config'
# require 'chef/knife'
# # current_dir = File.dirname(__FILE__)
# Chef::Config.from_file(File.expand_path('../.chef/knife.rb'))

VAGRANTFILE_API_VERSION = "2"
VM_BOX = "enemy-of-the-state/centos-7.1_kernel-devel-fixed"
Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

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

  my_nodes.each do |my_node|

    config.vm.define my_node[:name] do |config|
      if Vagrant.has_plugin?("vagrant-omnibus")
        config.omnibus.chef_version = "latest"
      end
      config.vm.box = VM_BOX
      config.vm.synced_folder ".", "/vagrant", disabled: true
      config.berkshelf.enabled = true
      # config.chef_zero.enabled = true
      # config.chef_zero.chef_repo_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/"
      config.vm.hostname = my_node[:name]
      config.vm.network :private_network, ip: my_node[:ip]
      my_node[:ports].each do |port|
        config.vm.network :forwarded_port, guest: port[:guest], host: port[:host]
      end
      config.vm.provider "virtualbox" do |vb|
        vb.memory = my_node[:memory]
      end
      # config.vm.provision :chef_solo do |chef|
      #   chef.log_level = "info"
      #   chef.node_name = my_node[:name]
      #   chef.encrypted_data_bag_secret_key_path # NEED TO SETUP
      #   chef.custom_config_path # NEED TO SETUP
      #   chef.provisioning_path # NEED TO SETUP
      #   chef.environments_path = "environments"
      #   chef.environment = "development"
      #   # chef.environment = "production"
      #   chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
      #   chef.roles_path = "roles"
      #   chef.data_bags_path = "data_bags"
      #   chef.json.merge!(JSON.parse(IO.read("nodes/#{my_node[:name]}-#{my_node[:ip]}.json")))
      # end
      config.vm.provision :chef_client do |chef|
        chef.chef_server_url = "https://api.chef.io/organizations/flashcards"
        # chef.chef_server_url = "http://192.168.1.102:8889"
        # chef.validation_key_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/.chef/dolgirev.pem"
        chef.validation_key_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/.chef/flashcards-validator.pem"
        chef.client_key_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/.chef/dolgirev.pem"
        chef.node_name = "#{my_node[:name]}-#{my_node[:ip]}"
        chef.validation_client_name = "flashcards-validator"
        # chef.json.merge!(JSON.parse(IO.read("nodes/#{my_node[:name]}-#{my_node[:ip]}.json")))
        # chef.delete_node = true
        # chef.delete_client = true
      end

      # config.vm.provision :chef_client do |chef|
      #   chef.chef_server_url = Chef::Config[:chef_server_url]
      #   chef.validation_key_path = Chef::Config[:validation_key]
      #   chef.validation_client_name = Chef::Config[:validation_client_name]
      #   # chef.node_name = options[:hostname]
      #   chef.node_name = "#{my_node[:name]}-#{my_node[:ip]}"
      #   chef.run_list = options[:run_list]
      #   chef.provisioning_path = "/etc/chef"
      #   chef.log_level = :info
      # end
      # config.vm.provision :chef_zero do |chef|
      #   chef.environments_path = "environments"
      #   chef.environment = "development"
      #   chef.nodes_path = "nodes"
      #   chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
      #   chef.roles_path = "roles"
      #   chef.data_bags_path = "data_bags"
      #   chef.node_name = "#{my_node[:name]}-#{my_node[:ip]}"
      #   chef.json.merge!(JSON.parse(IO.read("nodes/#{my_node[:name]}-#{my_node[:ip]}.json")))
      # end
    end
  end
end
