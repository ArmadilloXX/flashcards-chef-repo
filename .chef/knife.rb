current_dir = File.dirname(__FILE__)
cookbook_path            ["#{current_dir}/../cookbooks"]
node_path                ["#{current_dir}/../nodes"]
role_path                ["#{current_dir}/../roles"]
environment_path         ["#{current_dir}/../environments"]
data_bag_path            ["#{current_dir}/../data_bags"]
log_level                :info
log_location             STDOUT
client_key               "#{current_dir}/dolgirev.pem"
validation_key           "#{current_dir}/dolgirev.pem"
chef_server_url          "http://192.168.50.1:8889"
node_name                "workstation"
environment              "development"

# data_bag_encrypt_version 2
# encrypted_data_bag_secret "data_bag_key"
# knife[:secret_file]

knife[:editor] = "vim"
knife[:berkshelf_path] = "cookbooks"
knife[:vault_mode] = "client"
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef

# Config for Hosted Chef
# node_name                "dolgirev"
# client_key               "#{current_dir}/dolgirev.pem"
# validation_client_name   "flashcards-validator"
# validation_key           "#{current_dir}/flashcards-validator.pem"
# chef_server_url          "https://api.chef.io/organizations/flashcards"