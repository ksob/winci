require 'fileutils'
require 'jenkins'
require 'winci/jenkins_ext/job_config_builder'

module WinCI

  class Job
    attr_accessor :project_name, :config

    def initialize(project_name='files', config=std_config)
      @project_name = project_name
      @config = config
    end

    def std_config
      Jenkins::JobConfigBuilder.new(:ruby) do |c|
        c.scm = "C:/repos/files.git"
        c.steps = [
            [:build_bat_step, "bundle exec rake"],
            [:build_bat_step, "git push C:/repos/production/files.git HEAD:master"]
        ]
      end
    end


    def create server='127.0.0.1', port='3010'
      Jenkins::Api.setup_base_url(:host => server, :port => port)

      if Jenkins::Api.create_job(name=@project_name, @config, options = {:override => true}) == true
        return "#{@project_name} project created on jenkins"
      else
        raise "#{@project_name} project not created, something gone wrong or it already exist"
      end
    end

    def last_successful_build
      Jenkins::Api.job(@project_name)["lastSuccessfulBuild"]
    end

    def get_build_sha build
      # Retrieve information about the actual build, and grab the last built revision out of it
      build_info = Jenkins::Api.get("/job/#{@project_name}/#{build["number"]}/api/json")
      build_info['actions'].detect { |h| h["lastBuiltRevision"] }["lastBuiltRevision"]["SHA1"]
    end

    def last_successful_build_sha
      if last_successful_build
        return get_build_sha last_successful_build
      else
        raise 'There is none successful build yet!'
      end
    end

    def provide_build(build=last_successful_build_sha, environments=['production'])
      # TODO provide this build to selected environments
    end

  end
end

