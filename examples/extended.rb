require 'jenkins'
require 'winci'

project_name = 'files'

cfg = Jenkins::JobConfigBuilder.new(:ruby) do |c|
  c.scm = "C:/repos/#{project_name}.git"
  c.steps = [
      # in this way we can ensure that the PATH is the same as in production environment
    [:build_shell_step, "export PATH=C:/Ruby/bin;\r\n" + "echo PATH is now : $PATH"],
    # then we can run some installation script
    [:build_bat_step, "ruby install.rb"],
    # see basic.rb
    [:build_bat_step, "bundle exec rake"],
    # some adjustments to git before pushing
    [:build_bat_step, "git config core.hidedotfiles false"],
    # see basic.rb
    [:build_bat_step, "git push c:/repos/production/files.git HEAD:master"]
  ]
end

job = WinCI::Job.new project_name, cfg

job.create '192.168.1.10', '3010'