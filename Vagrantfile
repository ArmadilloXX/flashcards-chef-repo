# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
VM_BOX = "enemy-of-the-state/centos-7.1_kernel-devel-fixed"
Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # my_nodes = {
  #   "application" => "192.168.50.101",
  #   "elasticsearch" => "192.168.50.102",
  #   "kibana" => "192.168.50.103"
  # }

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
      my_node[:ports].each do |port|
        config.vm.network :forwarded_port, guest: port, host: port
      end
      config.vm.provider "virtualbox" do |vb|
        vb.memory = my_node[:memory]
      end
      config.vm.provision :chef_solo do |chef|
        chef.log_level = "info"
        chef.environments_path = "environments"
        chef.environment = "development"
        chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
        chef.roles_path = "roles"
        chef.data_bags_path = "data_bags"
        chef.json.merge!(JSON.parse(IO.read("nodes/#{my_node[:name]}-#{my_node[:ip]}.json")))
      end
    end
  end

  # config.vm.define "web" do |web|
  #   WEBAPP_DIR = "/home/vagrant/flashcards"
  #   if Vagrant.has_plugin?("vagrant-omnibus")
  #     web.omnibus.chef_version = "latest"
  #   end
  #   web.vm.provision "shell", inline: "echo ==== INSTALL WEB VM ===="
  #   web.vm.hostname = "webapp"
  #   web.berkshelf.enabled = true
  #   web.vm.box = VM_BOX
  #   web.vm.network :private_network, ip: "192.168.50.101"
  #   web.vm.network :forwarded_port, guest: 3000, host: 3000
  #   web.vm.network :forwarded_port, guest: 5432, host: 5432
  #   web.vm.network :forwarded_port, guest: 6379, host: 6379
  #   web.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
  #   web.vm.synced_folder ".", WEBAPP_DIR
  #   web.vm.provider "virtualbox" do |vb|
  #     vb.memory = "1024"
  #     vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  #   end
  #   web.vm.provision :chef_solo do |chef|
  #     chef.json = {
  #       application: {
  #         username: "vagrant",
  #         directory: WEBAPP_DIR
  #       },
  #       rbenv: {
  #         user: 'vagrant'
  #       }
  #     }
  #     chef.run_list = [
  #       "recipe[flashcards-cookbook::default]",
  #       "recipe[flashcards-cookbook::database]"
  #     ]
  #   end
  # end

  # config.vm.define "elastic" do |elastic|
  #   elastic.vm.provision "shell", inline: "echo ==== INSTALL ELASTIC VM ===="
  #   elastic.vm.box = VM_BOX
  #   elastic.vm.hostname = "elasticsearch"
  #   elastic.vm.network :private_network, ip: "192.168.50.102"
  #   elastic.berkshelf.enabled = true
  #   elastic.vm.network "forwarded_port", guest: 9200, host: 9200
  #   elastic.vm.network :forwarded_port, guest: 22, host: 10222, id: "ssh"
  #   elastic.vm.provider "virtualbox" do |vb|
  #     vb.memory = "1024"
  #   end
  #   elastic.vm.provision :chef_solo do |chef|
  #     chef.json = {}
  #     chef.run_list = [
  #       "recipe[flashcards-cookbook::elastic]"
  #     ]
  #   end
  # end

  # config.vm.define "kibana" do |kibana|
  #   kibana.vm.provision "shell", inline: "echo ==== INSTALL KIBANA VM ===="
  #   kibana.vm.box = VM_BOX
  #   kibana.vm.hostname = "kibana"
  #   kibana.vm.network :private_network, ip: "192.168.50.103"
  #   kibana.berkshelf.enabled = true
  #   kibana.vm.network "forwarded_port", guest: 82, host: 5601
  #   kibana.vm.network :forwarded_port, guest: 22, host: 10322, id: "ssh"
  #   kibana.vm.provider "virtualbox" do |vb|
  #     vb.memory = "1024"
  #   end
  #   kibana.vm.provision :chef_solo do |chef|
  #     chef.json = {
  #       kibana: {
  #         config: {
  #           elasticsearch_url: 'http://192.168.50.102:9200'
  #         }
  #       }
  #     }
  #     chef.run_list = [
  #       "recipe[flashcards-cookbook::kibana]"
  #     ]
  #   end
  # end
end
