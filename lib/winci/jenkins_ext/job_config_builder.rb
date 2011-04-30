module Jenkins
  class JobConfigBuilder
    def build_bat_step(b, command)
      b.tag! "hudson.tasks.BatchFile" do
        b.command command.to_xs.gsub("&amp;", '&')
      end
    end
  end
end