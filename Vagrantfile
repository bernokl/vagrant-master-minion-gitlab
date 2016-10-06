Vagrant.configure("2") do |config|
%w{
   lcl-minion
 }.each_with_index do |role, i|
  config.vm.define role  do |config|
    ## Choose your base box
    config.vm.box_url = "berno/salt-minion-1404"
    config.vm.box = "berno/salt-minion-1404"
   
    config.vm.provider "virtualbox" do |v|
    config.vm.synced_folder "salt/", "/srv", owner: "root", group: "root"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
 
    config.vm.hostname = role
     if role.eql? 'lcl-minion'
        config.vm.network "private_network", ip: "192.168.50.4"
        config.vm.define "lcl-minion"
     end

    config.vm.provision :shell do |shell|
      shell.inline = "rm -f /etc/salt/minion_id"
    end

    config.vm.provision :salt do |config|

      config.minion_config = "salt/salt-configs/minion"
      config.run_highstate = true
      config.install_type = "git"
      config.install_args = "v2016.3.2"
      config.verbose = true
      
      config.minion_config = "salt/salt-configs/minion"
      config.minion_key = "salt/salt-keys/minion2.pem"
      config.minion_pub = "salt/salt-keys/minion2.pub"
    end
  end
end
  config.vm.define "lcl-master"  do |config|
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    config.vm.box = "trusty"
    config.vm.provider "virtualbox" do |v|
    config.vm.synced_folder "salt/", "/srv", owner: "root", group: "root"
      v.customize ["modifyvm", :id, "--memory", "512"]
    end
    config.vm.hostname = 'lcl-master'
    config.vm.network "private_network", ip: "192.168.50.3"

## Accept the minion key on the master
#    config.vm.provision :shell do |shell|
#      shell.inline = "salt-key -A"
#    end
    
    config.vm.provision :salt do |config|

      config.minion_config = "salt/salt-configs/minion"
      config.minion_key = "salt/salt-keys/minion2.pem"
      config.minion_pub = "salt/salt-keys/minion2.pub"

      config.master_key = 'salt/salt-keys/masterkey.pem'
      config.master_pub = 'salt/salt-keys/masterkey.pub'
      config.master_config = "salt/salt-configs/master"
     
## Lets just pre-seed the keys 
      config.seed_master = {
           'lcl-minion' => "salt/salt-keys/minion2.pub",
           'lcl-master' => "salt/salt-keys/minion2.pub",
        }
      
      config.install_master = true
      config.run_highstate = false
      config.install_type = "git"
      config.install_args = "v2016.3.2"
      config.verbose = true
    end
  end
end

