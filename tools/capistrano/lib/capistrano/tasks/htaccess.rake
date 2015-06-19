namespace :htaccess do

  desc 'Create empty .htaccess file if it doesnt exist'
  task :touch_htaccess do
    on roles(:app) do |host|
      within shared_path do
        if test("[ -e #{shared_path}/public/.htaccess ]")
        else
            execute "mkdir -p #{shared_path}/public/ && touch #{shared_path}/public/.htaccess && chmod ugo+w #{shared_path}/public/.htaccess"
            puts ".htaccess touched"
        end
      end
    end
  end
end