# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrnshots/version"

Gem::Specification.new do |s|
  s.name        = "scrnshots"
  s.version     = "1.0.0"
  s.authors     = ["Greg Bell"]
  s.email       = ["gregdbell@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Download all your Screenshots stored on ScrnShots.com}
  s.description = %q{Download all your Screenshots stored on ScrnShots.com}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "httparty"
end
