require 'mina/git'
require 'mina/puma'
require 'mina/rails'
require 'mina/rvm'

set :application_name, 'young'
set :domain, '93.188.163.140'
set :deploy_to, '/home/deploy/youngnigerian'
set :repository, 'git@github.com:alfie-max/young.git'
set :branch, 'master'
set :user, 'deploy'          # Username in the server to SSH to.
set :forward_agent, true     # SSH forward_agent.

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key')

task :remote_environment do
  invoke :'rvm:use', 'ruby-2.6.3'
end

task :setup do
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/credentials.yml.enc"]
  command %[touch "#{fetch(:shared_path)}/config/master.key"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml'."
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    comment "Deploying #{fetch(:application_name)} to #{fetch(:domain)}:#{fetch(:deploy_to)}"

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_create'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'puma:stop'
        invoke :'puma:start'
      end
    end
  end
end

namespace :tail do
  desc 'Lists logs available to tail'
  task :list do
    in_path "#{fetch(:current_path)}" do
      log_path = "#{fetch(:current_path)}/log"
      command %{
        echo "-----> Log files in #{log_path}"
        #{%[ls #{log_path} | grep log]}
      }
    end
  end
  desc 'Shows live environment logs'
  task :live do
    in_path "#{fetch(:current_path)}" do
      file = ENV['file'] || "#{fetch(:rails_env)}.log"
      command %[tail -f log/#{file}]
    end
  end
  desc 'Show last lines of the environment logs'
  task :last do
    in_path "#{fetch(:current_path)}" do
      lines = ENV['lines'] || 2000
      file = ENV['file'] || "#{fetch(:rails_env)}.log"
      command %[tail -#{lines} log/#{file}]
    end
  end
end
