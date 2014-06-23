# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "knife-cookbook-tagger/version"

Gem::Specification.new do |s|
  s.name        = "knife-cookbook-tagger"
  s.version     = Knife::CookbookTagger::VERSION
  s.authors     = ["David Gouveia"]
  s.email       = ["david.gouveia@gmail.com"]
  s.homepage    = "https://github.com/zatarra/knife-cookbook-tagger"
  s.summary     = %q{Chef knife plugin to tag new cookbook versions}
  s.description = s.summary
  s.license     = "Apache 2.0"

#  s.rubyforge_project = "knife-cookbook-tagger"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "chef", ">= 0.10.10"
  
  s.add_development_dependency "rspec", "~> 2.10"
end
