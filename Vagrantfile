VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.synced_folder '.', '/vagrant'

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end

  config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    etc_hosts = "10.10.10.9 pgpool\n10.10.10.10 pg10\n10.10.10.11 pg11\n10.10.10.12 pg12\n"
    s.inline = <<-SHELL
      echo '#{ssh_pub_key}' >> /home/ubuntu/.ssh/authorized_keys
      echo '#{etc_hosts}' >> /etc/hosts
    SHELL
  end

  (10..12).each do |i|
    config.vm.define "pg#{i}" do |node|
      node.vm.hostname = "pg#{i}"
      node.vm.network :private_network, ip: "10.10.10.#{i}"
    end
  end

  config.vm.define "pgpool" do |node|
    node.vm.hostname = "pgpool"
    node.vm.network :private_network, ip: "10.10.10.9"
  end
end
