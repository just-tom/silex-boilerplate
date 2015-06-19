# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
server '**server ip**', user: '**server user**', roles: %w{app web}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.

# Which Git branch
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Deploy location
set :deploy_to, '**set path to deploy to**'

# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
 set :ssh_options, {
   forward_agent: true,
 }
