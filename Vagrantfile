# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'chef'
Chef::Config.from_file(File.join(File.dirname(__FILE__), '.chef', 'knife.rb'))

VAGRANTFILE_API_VERSION = "2"
VM_BOX = "enemy-of-the-state/centos-7.1_kernel-devel-fixed"
Vagrant.require_version ">= 1.5.0"

nodes = {
  application: {
    hostname: "application",
    ipaddress: "192.168.50.101",
    memory: 1024,
    forwardports: [
      { host: 3000, guest: 80 },
    ],
    run_list: [
      "role[application]",
      "role[database]",
      "role[redis]",
      "recipe[flashcards-cookbook::deploy]"
    ]
  },
  elasticsearch: {
    hostname: "elasticsearch",
    ipaddress: "192.168.50.102",
    memory: 1024,
    forwardports: [],
    run_list: ["role[elasticsearch]"]
  },
  kibana: {
    hostname: "kibana",
    ipaddress: "192.168.50.103",
    memory: 1024,
    forwardports: [],
    run_list: ["role[kibana]"]
  }
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  nodes.each do |node, node_config|

    config.vm.define node do |config|
      if Vagrant.has_plugin?("vagrant-omnibus")
        config.omnibus.chef_version = "latest"
      end

      if Vagrant.has_plugin?("vagrant-cachier")
        config.cache.scope = :machine
      end

      config.berkshelf.enabled = true

      config.vm.box = VM_BOX
      config.vm.synced_folder ".", "/vagrant", disabled: true

      config.vm.hostname = node_config[:hostname]
      config.vm.network :private_network, ip: node_config[:ipaddress]
      if node_config.has_key?(:forwardports)
        node_config[:forwardports].each do |port|
          config.vm.network :forwarded_port,
                            guest: port[:guest],
                            host: port[:host]
        end
      end

      config.vm.provider "virtualbox" do |vb|
        vb.memory = node_config[:memory]
      end

      config.vm.provision :chef_client do |chef|
        chef.chef_server_url = Chef::Config[:chef_server_url]
        chef.client_key_path = Chef::Config[:client_key]
        chef.validation_key_path = Chef::Config[:validation_key]
        chef.node_name = "#{node}-#{node_config[:ipaddress]}"
        if Chef::Config[:encrypted_data_bag_secret_key_path]
          chef.encrypted_data_bag_secret_key_path =
            Chef::Config[:encrypted_data_bag_secret_key_path]
        end
        chef.environment = Chef::Config[:environment]
        chef.provisioning_path = "/etc/chef"
        chef.log_level = Chef::Config[:log_level]
        chef.run_list = node_config[:run_list]
      end
    end
  end
end
