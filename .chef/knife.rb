# cookbook_path    ["cookbooks", "site-cookbooks"]
# node_path        "nodes"
# role_path        "roles"
# environment_path "environments"
# data_bag_path    "data_bags"
#encrypted_data_bag_secret "data_bag_key"
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "dolgirev"
client_key               "#{current_dir}/dolgirev.pem"
validation_client_name   "flashcards-validator"
validation_key           "#{current_dir}/flashcards-validator.pem"
chef_server_url          "https://api.chef.io/organizations/flashcards"
cookbook_path            ["#{current_dir}/../cookbooks"]
node_path                ["#{current_dir}/../nodes"]
role_path                ["#{current_dir}/../roles"]
environment_path         ["#{current_dir}/../environments"]
data_bag_path            ["#{current_dir}/../data_bags"]
# encrypted_data_bag_secret "data_bag_key"

knife[:berkshelf_path] = "cookbooks"
knife[:vault_mode] = "solo"
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
