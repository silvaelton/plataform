$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "schedule/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "schedule"
  s.version     = Schedule::VERSION
  s.authors     = ["elton.silva@codhab.df.gov.br"]
  s.email       = ["elton.silva@codhab.df.gov.br"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Schedule."
  s.description = "TODO: Description of Schedule."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end