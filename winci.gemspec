# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "winci/version"

Gem::Specification.new do |s|
  s.name        = "winci"
  s.version     = WinCI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kamil Sobieraj"]
  s.email       = ["ksob@rubyforge.org"]
  s.homepage    = ""
  s.summary     = %q{Simplifies continuous integration under Windows}
  s.description = %q{Implements full continuous deployment pipeline the Agile way with Jenkins/Hudson continuous integration server under Windows.}

  s.rubyforge_project = "winci"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('jenkins', '~> 0.6.2')
end
