lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require_relative './version'

Gem::Specification.new do |s|
  s.name          = 'validates_subset'
  s.version       = ValidatesSubset::VERSION
  s.summary       = %q{Subset validation for ActiveModel/ActiveRecord models}
  s.description   = %q{This library helps validate that an attribute is a subset of a specified set}
  s.authors       = ['Jake Yesbeck']
  s.email         = 'yesbeckjs@gmail.com'
  s.homepage      = 'http://rubygems.org/gems/validates_subset'
  s.license       = 'MIT'

  s.require_paths = ['lib']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(/^spec\//)

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'activemodel', '>= 3.0.0'

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
