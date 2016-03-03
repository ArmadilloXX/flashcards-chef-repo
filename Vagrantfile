# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VM_BOX = "enemy-of-the-state/centos-7.1_kernel-devel-fixed"
Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  my_nodes = [
    { name: 'application', ip: '192.168.50.101', ports: [3000, 5432, 6379], memory: 1024 },
    { name: 'elasticsearch', ip: '192.168.50.102', ports: [9200], memory: 1024 },
    { name: 'kibana', ip: '192.168.50.103', ports: [], memory: 1024}
  ]

  my_nodes.each do |my_node|

    config.vm.define my_node[:name] do |config|
      if Vagrant.has_plugin?("vagrant-omnibus")
        config.omnibus.chef_version = "latest"
      end
      config.vm.box = VM_BOX
      config.berkshelf.enabled = true
      config.vm.hostname = my_node[:name]
      config.vm.network :private_network, ip: my_node[:ip]
      #TODO Add feature to use different ports
      my_node[:ports].each do |port|
        config.vm.network :forwarded_port, guest: port, host: port
      end
      config.vm.provider "virtualbox" do |vb|
        vb.memory = my_node[:memory]
      end
      # config.vm.provision :chef_solo do |chef|
      #   chef.log_level = "info"
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
        chef.validation_key_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/.chef/flashcards-validator.pem"
        chef.client_key_path = "/Users/Ilya/Coding/RoR/mkdev/flashcards-chef-repo/.chef/dolgirev.pem"
        chef.node_name = "#{my_node[:name]}-#{my_node[:ip]}"
        chef.validation_client_name = "flashcards-validator"
        chef.delete_node = true
        # chef.delete_client = true
      end
    end
  end
end
