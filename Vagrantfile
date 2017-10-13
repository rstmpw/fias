# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "CentOS7"
  config.vm.box_url = "http://files.rstm.pw/vagrant/CentOS7.json"

  config.vm.network "private_network", ip: "192.168.222.201"

  # Prev run on vagrant host:
  # vagrant plugin install vagrant-vbguest
  config.vm.synced_folder "./", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vbox|
    vbox.name = "fias"

    # Get disk path
    def_folder = `VBoxManage list systemproperties | grep "Default machine folder"`
    machine_folder = def_folder.split(':')[1].strip()
    second_disk = File.join(machine_folder, vbox.name, 'disk2.vmdk')

    # Create and attach disk 10G
    unless File.exist?(second_disk)
      vbox.customize [ "createmedium", "disk", "--filename", second_disk, "--format", "vmdk", "--size", 1024 * 100 + 1 ]
    end
    vbox.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 0, '--device', 1, '--type', 'hdd', '--medium', second_disk]
  end

  # Create and mount fs on 10G disk
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum install -y system-storage-manager
    sudo mkdir /opt/fias
    sudo ssm create -s 100G -n ProjectLV --fstype xfs -p ProjectVG /dev/sdb /opt/fias
    echo "/dev/mapper/ProjectVG-ProjectLV /opt/fias        xfs     defaults        0 0" | sudo tee -a /etc/fstab
  SHELL

  # Install env
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/rstmpw/docker/master/install.centos7.sh"
  config.vm.provision "shell", name: "PHP", inline: <<-SHELL
    /vagrant/provision/provision.sh
  SHELL

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    /vagrant/devtools/phpfpmreload.sh
    /vagrant/devtools/nginxreload.sh
  SHELL
end