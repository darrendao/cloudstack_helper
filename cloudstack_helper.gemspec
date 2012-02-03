# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "cloudstack_helper"
  s.version     = "0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Darren Dao"]
  s.email       = ["darrendao@gmail.com"]
  s.homepage    = "https://github.com/darrendao/cloudstack_helper"
  s.summary     = %q{cloudstack_helper is a simple ruby library that helps making request to CloudStack API easier.}
  s.description = %q{cloudstack_helper is a simple ruby library that helps making request to CloudStack API easier. With cloudstack_helper, you only have to specify the command the parameters for the request and it will handle everything for you.}

  s.add_runtime_dependency 'rest-client', '~> 1.6.7'
  s.add_development_dependency 'yard', '~> 0.7'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables      = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths    = ["lib"]
  s.extra_rdoc_files = ["README.md"]
end

