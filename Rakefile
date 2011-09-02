# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

begin
  require 'vlad'
  require 'vlad-extras'
  Vlad.load(:scm => :git, :web => :nginx, :app => :passenger, :type => :rails)
rescue LoadError
  puts 'Could not load Vlad'
end

Fulcrum::Application.load_tasks
