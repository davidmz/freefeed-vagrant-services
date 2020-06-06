Vagrant.configure("2") do |config|
  config.vm.box = "generic/alpine312"
  config.vm.define "freefeed"
  config.vm.provision "shell", path: "bootstrap.sh", privileged: false

  config.vm.provider "virtualbox" do |prv|
    prv.name = "freefeed"
    prv.memory = "2048"
  end

  config.vm.provider "hyperv" do |prv|
    prv.vmname = "freefeed"
    prv.memory = "2048"
  end
end