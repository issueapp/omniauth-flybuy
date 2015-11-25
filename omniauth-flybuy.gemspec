require File.dirname(__FILE__) + '/lib/omniauth-flybuy/version'

Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'omniauth', '~> 1.0'
  gem.add_runtime_dependency 'mechanize', '~> 2.7.3'

  gem.add_development_dependency 'rack-test', '~> 0.5'

  gem.name = 'omniauth-flybuy'
  gem.version = OmniAuth::Flybuy::VERSION
  gem.description = %q{Authenticate with Coles Flybuy}
  gem.summary = gem.description
  gem.email = ['khoa@issue.by']
  gem.homepage = 'http://github.com/issueapp/omniauth-flybuy'
  gem.authors = ['Khoa']
  gem.license     = 'MIT'
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {spec}/*`.split("\n")
  gem.require_paths = ['lib']
end
