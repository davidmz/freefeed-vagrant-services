Vagrant.configure("2") do |config|
  #
  # PostgreSQL
  #
  # ⚠ WARNING To prevent collisions this VM exposes 
  # non-standard port for the PostgreSQL: 15432 (instead of 5432).
  # You can change its value below if you want.
  # Do not forget to modify the 'local.json' also.
  config.vm.network "forwarded_port", guest: 5432, host: 15432

  #
  # Redis
  #
  # ⚠ WARNING To prevent collisions this VM exposes 
  # non-standard port for the Redis: 16379 (instead of 6379).
  # You can change its value below if you want.
  # Do not forget to modify the 'local.json' also.
  config.vm.network "forwarded_port", guest: 6379, host: 16379

  #----------------------------------------------------------------
  config.vm.box = "generic/ubuntu1804"
  config.vm.provision "shell", path: "bootstrap.sh", privileged: false
  config.vm.hostname = "freefeed"
  config.vm.define "freefeed"

  config.vm.provider "virtualbox" do |prv|
    prv.name = "freefeed"
    prv.memory = "2048"
  end

  config.vm.provider "hyperv" do |prv|
    prv.vmname = "freefeed"
    prv.memory = "2048"
  end
end
