# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Save some time on vagrant up
  config.vbguest.auto_update = false

  config.vm.define :snm do |snm|
    snm.vm.box = "CentOS"
    snm.vm.box_url = "https://s3-eu-west-1.amazonaws.com/snm-nl-hostingsupport-test/vagrant-centos-6-4.box"
    snm.vm.hostname = "sanoma.local"

    # snm.vm.provision "shell", inline: 'echo "Installing r10k inside the Vagrant box"'
    snm.vm.provision "shell", inline: 'gem query --name r10k --installed &> /dev/null || (echo "Installing r10k inside the Vagrant box"; gem install --no-rdoc --no-ri r10k)'
    snm.vm.provision "shell", inline: 'cd /vagrant/deploy/puppet/environments/common && r10k -v info puppetfile install'

    snm.vm.provision :puppet do |puppet|
      puppet.facter = {
	# The included version of facter is too old to work with the (most recent) Epel module...
        "operatingsystemmajrelease" => "6"
      }
      puppet.hiera_config_path = "deploy/hiera/hiera.yaml"
      puppet.working_directory = "/vagrant/deploy/"
      puppet.manifests_path = "deploy/puppet/manifests"
      puppet.module_path = ["deploy/puppet/environments/development/modules","deploy/puppet/environments/common/modules"]
      puppet.manifest_file  = "snm.pp"
      puppet.options = "--environment development --verbose"
    end

    snm.vm.network "forwarded_port", guest: 80, host: 8000
    snm.vm.post_up_message = "Find the Mezzanine website at: http://localhost:8000"
  end

end
