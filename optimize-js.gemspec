# encoding: utf-8
# frozen_string_literal: true

$:.push File.expand_path('../lib', __FILE__)
require 'optimize-js/version'

Gem::Specification.new do |s|
  s.name            = 'optimize-js'
  s.version         = OptimizeJS::GEM_VERSION
  s.author          = 'Yaroslav Konoplov'
  s.email           = 'eahome00@gmail.com'
  s.summary         = 'Ruby wrapper and Rails asset pipeline integration for optimize-js.'
  s.description     = 'optimize-js makes JavaScript scripts initialize faster. This gem provides Ruby and Rails asset pipeline integration for optimize-js.'
  s.homepage        = 'https://github.com/yivo/optimize-js'
  s.license         = 'MIT'

  s.executables     = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
  s.files           = `git ls-files -z`.split("\x0")
  s.files          += ['optimize-js.web.min.js']
  s.test_files      = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
  s.require_paths   = ['lib']

  s.add_dependency 'execjs', '>= 1'
  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'appraisal', '~> 2.1'
  s.add_development_dependency 'test-unit', '~> 3.1'
end
