require 'rubygems'
require 'jenkins'
require 'winci'

project_name = 'files'

cfg = Jenkins::JobConfigBuilder.new(:ruby) do |c|
  c.scm = "C:/repos/#{project_name}.git"
  c.steps = [
    # below makes sense when your Rakefile run rspec/cucumber by default
    [:build_bat_step, "bundle exec rake"],
    # this will send current code to production repo only after rspec/cucumber passed
    [:build_bat_step, "git push c:/repos/production/#{project_name}.git HEAD:master"]
  ]
end

job = WinCI::Job.new project_name, cfg

# by default creates job on localhost:3010
puts job.create