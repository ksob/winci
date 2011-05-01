winci
======

[WinCI] Simplifies mplementation of a full continuous deployment pipeline the Agile way with Jenkins/Hudson continuous integration server under Windows.

Install
=======

    gem install winci

Introduction
=======

The purpose of this project is to simplify implementation of the full continuous deployment pipeline the Agile way with Jenkins/Hudson continuous integration server under Windows.
It will let Windows developers get quickly up and running with continuous deployment pipeline and 
continuous integration by incorporating convention-over-configuration paradigm, so that the novice is first presented with 
working setup with the click of a button and after he see it working and have overall empirical knowledge under his belt, 
only then is he introduced to some configuration options.

WinCI is written in Ruby and uses Jenkins.rb gem to automate installation and interaction with Jenkins CI and also ruby-git gem to automate CI provisioning.

WinCI is intended to be be used in conjunction with WinCI-server [https://github.com/ksob/winci-server] and WinCI-updater [https://github.com/ksob/winci-updater] projects.

WinCI-server provides functionality necessary to setup Jenkins CI and enabling to create installation bundle used in provisioning process and WinCI-updater plays huge role in the provisioning process.

Usage
=====

First download and run WinCI-server.
Then you can start using this gem, first take a look at examples directory. 
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