# If Vlad does not find some commands, try the following:
#
# To enable per user PATH environments for ssh logins you
# need to add to your sshd_config:
# PermitUserEnvironment yes
#
# After that, restart sshd!
#
# Then in your "users" ssh home directory (~/.ssh/environment),
# add something to this effect (your mileage will vary):
# PATH=/opt/ruby-1.8.7/bin:/usr/local/bin:/bin:/usr/bin
#
# For details on that, see:
# http://zerobearing.com/2009/04/27/capistrano-rake-command-not-found
#
# Maybe you also need to configure SSH Agent Forwarding:
#
# $ ssh-add ~/.ssh/<private_keyname>
#
# Edit your ~/.ssh/config file and add something like this:
# Host <name>
#   HostName <ip or host>
#   User <username>
#   IdentityFile ~/.ssh/<filename>
#   ForwardAgent yes
#
# For details on that, see:
# http://jordanelver.co.uk/articles/2008/07/10/rails-deployment-with-git-vlad-and-ssh-agent-forwarding/

set :user, "deploy"
set :application, "fulcrum"
set :domain, "178.77.76.127" 
set :deploy_to, "/var/www/#{application}"
set :repository, "git@github.com:erotte/#{application}.git"
# set :repository, "git://github.com/malclocke/fulcrum.git"
# Revision defaults to master
# set :revision, "origin/develop"
set :bundle_cmd, "/usr/local/rvm/gems/ree-1.8.7-2011.03/bin/bundle"
set :web_command, "/etc/init.d/nginx"
# set :symlinks, { 'config/database.yml' => 'config/database.yml' }

role :app, domain
role :web, domain
role :db,  domain, :primary => true

require 'bundler/vlad'

namespace :vlad do
  desc "Full deployment cycle: Update, install bundle, migrate, restart, cleanup"
  remote_task :deploy, :roles => :app do
    %w(update symlink bundle:install migrate compass:compile_css start_app cleanup).each do |task|
      Rake::Task["vlad:#{task}"].invoke
    end
  end

  namespace :compass do
    desc "compile compressed stylesheets in production mode (remotely)"
    remote_task :compile_css, :roles => :app do
      run "cd #{current_path} && RAILS_ENV=#{rails_env} && #{bundle_cmd} exec compass compile -e production --force"
    end
  end
end
