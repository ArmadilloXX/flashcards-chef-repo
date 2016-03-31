##DESCRIPTION

This repo helps to set up development environment for Flashcards application or deploy it.

##Requirements
  - Vagrant Chef Plugin

##USAGE

  - Start Chef Zero
  - Upload your repo to Chef Zero with `knife upload .` from the root of the repo
  - Run `vagrant up`

  ###OR

  - `knife serve --chef-zero-host IP` (I do recommend to use IP assigned to your main network interface to avoid potential issues when assign the custom one).
  - Run `vagrant up`

  I prefer that one. `knife serve` is more verbose and it creates some new directories in your repo, such as `clients` and `nodes`. You can get additional info about your machines from there.
  If you have issues with net-ssh gem versions (knife-solo 0.5.1 etc.) uncompatibility please use Chef Zero as descripted above.

##TODO

  - Test Vagrant plugin config - got some issues with knife-serve when assign custom IP
