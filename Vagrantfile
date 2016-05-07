VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "hashicorp/precise64"
		
	config.vm.define :web do |web_config|
		web_config.vm.network :forwarded_port, guest: 80, host: 8090
		web_config.vm.network :forwarded_port, guest: 3000, host: 3000
		web_config.vm.network :forwarded_port, guest: 8000, host: 8000
		web_config.vm.synced_folder "www", "/var/www", create: true
		web_config.vm.provision :puppet do |puppet|
			puppet.manifests_path = 'puppet/manifests'			
			puppet.manifest_file = 'manifest.pp'
		end
	end
end