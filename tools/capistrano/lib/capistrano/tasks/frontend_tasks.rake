namespace :frontend do

	desc 'Install node packages else echo error'
	task :npm_install do
		run_locally do
				execute "cd #{fetch(:local_path)}public/assets && sudo npm install"
		end
	end

	desc 'Install bower packages else echo error'
	task :bower_install do
		run_locally do
				execute "cd #{fetch(:local_path)}public/assets && bower install --config.interactive=false"
		end
	end

	desc 'Build all gulp tasks'
	task :gulp_build do
		run_locally do
				execute "cd #{fetch(:local_path)}public/assets && gulp build"
		end
	end

	desc 'Sync assets to server'
	task :sync do
		on roles(:web) do
		  upload! "#{fetch(:local_path)}public/assets/dist", "#{release_path}/public/assets/dist", recursive: true
		end
	end

end