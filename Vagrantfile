# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "dummy"
  config.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"


  ## AWS
  config.vm.provider :aws do |aws, override|
    aws.access_key_id     = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name      = ENV['AWS_EC2_KEYPAIR']

    aws.region = "us-east-1"
    aws.ami = "ami-59a4a230" # Ubuntu12.04.3 LTS 64bit

    #aws.security_groups = 'default'
    aws.instance_type = "t1.micro"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ENV['AWS_EC2_KEYPAIR_PATH']
  end

  config.vm.provision :shell, :path => "bootstrap.sh"
end
