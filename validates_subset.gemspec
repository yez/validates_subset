# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require './version'

Gem::Specification.new do |s|
  s.name          = 'validates_subset'
  s.version       = ValidatesSubset::VERSION
  s.summary       = 'Subset validation for ActiveModel/ActiveRecord models'
  s.description   = 'This library helps validate that an attribute is a subset of a specified set'
  s.authors       = ['Jake Yesbeck']
  s.email         = 'yesbeckjs@gmail.com'
  s.homepage      = 'http://rubygems.org/gems/validates_subset'
  s.license       = 'MIT'

  s.require_paths = ['lib']
  s.files         = `git ls-files`.split("\n")
  s.test_files    = s.files.grep(%r{^spec/})

  s.required_ruby_version = '>= 2.0'

  s.add_dependency 'activemodel', '>= 3.2', '< 5.0'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop'
end
