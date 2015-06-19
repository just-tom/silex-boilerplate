# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'app_name'
set :repo_url, '**some_repository_url**'

#The root of your project locally (not on the server)
set :local_path, File.join(Dir.pwd,'..','../')

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('public/.htaccess')

SSHKit.config.command_map[:composer] = "composer.phar"
set :composer_install_flags, '--no-dev --no-interaction --optimize-autoloader'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
    after :starting, 'composer:install_executable'
    after :updated, 'frontend:npm_install'
    after :updated, 'frontend:bower_install'
    after :updated, 'frontend:gulp_build'
    after :updated, 'frontend:sync'
end
after 'deploy:check:directories', 'htaccess:touch_htaccess'