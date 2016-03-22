##DESCRIPTION

This repo helps to set up development environment for Flashcards application or deploy it.

##Requirements
  - Vagrant Chef Plugin

##USAGE

  - Start Chef Zero 
  - Upload your repo to Chef Zero with `knife upload .` from root repo directory
  - Run `vagrant up`

  ###OR

  - `knife serve --chef-zero-host IP`
  - Run `vagrant up`

##TODO

  - Test Vagrant plugin config - got some issues with knife-serve when assign custom IP
  - Try different config with vagrant-chef-zero plugin
  - Try to increase timeout for systemd kibana service start/stop operations


