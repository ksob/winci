winci
=====

[WinCI] Simplifies implementation of a full continuous deployment pipeline the Agile way with Jenkins/Hudson continuous integration server under Windows.

Introduction
============

The purpose of this project is to simplify implementation of the full continuous deployment pipeline the Agile way with Jenkins/Hudson continuous integration server under Windows.
It will let Windows developers get quickly up and running with continuous deployment pipeline and 
continuous integration by incorporating convention-over-configuration paradigm, so that the novice is first presented with 
working setup with the click of a button and after he see it working and have overall empirical knowledge under his belt, 
only then is he introduced to some configuration options.

WinCI is written in Ruby and uses Jenkins.rb gem to automate installation and interaction with Jenkins CI and also ruby-git gem to automate CI provisioning.

WinCI is intended to be used in conjunction with WinCI-server [https://github.com/ksob/winci-server] and WinCI-updater [https://github.com/ksob/winci-updater] projects.

WinCI-server provides functionality necessary to setup Jenkins CI and enabling to create installation bundle used in provisioning process and WinCI-updater plays huge role in the provisioning process.

Why This Project
=======

I needed to be able to exactly replicate every part of the continuous deployment pipeline installation process under Windows. To do so I needed to have at least perfectly working dependencies system. Bundler with Gemfile.lock system was the best to choose at the time of writing. Another aspect was solid provisioning process. At the time of writing such projects like Puppet or Capistrano were hard to port onto Windows platform so eventually I decided write my own using MSysGit and available wrapper gems. For details go to: https://github.com/ksob/winci-updater

Install
=======

    gem install winci
	
Usage
=====

First install and run WinCI-server [https://github.com/ksob/winci-server]

Then you can start using winci gem like this:

	require 'rubygems'
	require 'jenkins'
	require 'winci'

	project_name = 'my_project'

	cfg = Jenkins::JobConfigBuilder.new(:ruby) do |c|
	  c.scm = "C:/repos/#{project_name}.git"
	  c.steps = [
		# then we can run some installation script
		[:build_bat_step, "ruby install.rb"],
		# below makes sense when your Rakefile run rspec/cucumber by default
		[:build_bat_step, "bundle exec rake"],
		# this will send current code to production repo only after rspec/cucumber passed
		[:build_bat_step, "git push c:/repos/production/#{project_name}.git HEAD:master"]
	  ]
	end

	job = WinCI::Job.new project_name, cfg

	# by default creates job on localhost:3010
	puts job.create

For more examples take a look at examples directory. 

Then use your browser to navigate to http://localhost:3010/ and click at the Build Now button.
(In the future you will probably need to set "Poll SCM" in job configuration so that Jenkins will do it automatically when any change to the repo has been registered)

When the build succeeded you can now start using WinCI-updater [https://github.com/ksob/winci-updater] to deploy the successful build into all of your environments (testing, developement, production etc).

The WinCI-server [https://github.com/ksob/winci-server] ships with a script that uses the WinCI-updater to do the provisioning so as a default you don't need to cope with WinCI-updater at all, except for specifying the production repo in the _config.yaml so that WinCI-updater knows where to get updates from.
In case of the above example when you use updater locally your _config.yaml should contain:

	:SCMs:
	- "c:/repos/production/my_project.git"
	
When you use it from remote, that would look simmilarily to this:

	:SCMs:
	- "ssh://git@192.168.1.99/repos/production/my_project.git"
	
It is essential for your repository to follow some conventions so that when the "bundle exec rake"
command is called inside of it by Jenkins it should trigger unit tests execution. It is optimal to have install.rb file inside that would install the bundler and then install all project gems locally using the bundler itself.

This project ships with a scaffold of the repository described above. The scaffold contains the install.rb togeher with some additional scripts. You can move your project files onto this scaffold and/or customize it.

Another solution is to remove bundler installation part from the scaffold and assume that the
bundler is preinstalled.



Notes
=====

Keep in mind that so far this project is mostly a wrapper for functionality contained in Jenkins.rb gem,
so if you would like to create nodes in Jenkins or create rake build steps then you should look at Jenkins.rb gem's docs or API file.

License
=======

(The MIT License)

Copyright (c) 2011 Kamil Sobieraj, ksobej@gmail.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.