$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "solidus_locale_ja/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "solidus_locale_ja"
  s.version     = SolidusLocaleJa::VERSION
  s.authors     = ["FUNABARA Masao"]
  s.email       = ["masao@masoo.jp"]
  s.homepage    = "https://github.com/masoo/solidus_locale_ja"
  s.summary     = "Solidus Japanese Locale Gem."
  s.description = "It provides the Japanese to Solidus."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "solidus", "~> 1.3.0"

  s.add_development_dependency "sqlite3"
end
