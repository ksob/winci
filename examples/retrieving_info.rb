require 'winci'

project_name = 'files'

job = WinCI::Job.new project_name

puts job.last_successful_build
puts job.last_successful_build_sha