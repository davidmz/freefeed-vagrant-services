Vagrant.configure("2") do |config|
  #
  # PostgreSQL
  #
  # ⚠ WARNING To prevent collisions this VM exposes 
  # non-standard port for the PostgreSQL: 15432 (instead of 5432).
  # You can change its value below if you want.
  # Do not forget to modify the 'knexfile.js' also.
  config.vm.network "forwarded_port", guest: 5432, host: 15432

  #
  # Redis
  #
  # ⚠ WARNING To prevent collisions this VM exposes 
  # non-standard port for the Redis: 16379 (instead of 6379).
  # You can change its value below if you want.
  config.vm.network "forwarded_port", guest: 6379, host: 16379

  #----------------------------------------------------------------
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", path: "bootstrap.sh", privileged: false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "freefeed"
    vb.memory = "2048"
  end
end
