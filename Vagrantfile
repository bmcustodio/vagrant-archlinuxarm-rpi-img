# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"

    disk = File.join(File.dirname(__FILE__), 'sdcard.vdi')

    vb.customize [
      "createhd", "--filename", disk, "--format", "VDI", "--size", 1024
    ] if ! File.exist?(disk)

    vb.customize [
      "storageattach", :id, "--storagectl", "IDE Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", disk
    ]
  end
  
  config.vm.provision :shell, :inline => <<-SHELL
    sudo pacman -S --noconfirm dosfstools pv wget
  SHELL
end
