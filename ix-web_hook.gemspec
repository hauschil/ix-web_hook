require './lib/ix/web_hook/version'

Gem::Specification.new do |spec|
  spec.name          = 'ix-web_hook'
  spec.version       = IX::WebHook::VERSION::STRING
  spec.authors       = ['Daniel Hauschildt']
  spec.email         = ['daniel.hauschildt@gmail.com']
  spec.summary       = %q{A Ruby Web Hook handler with configurable delivery methods}
  spec.description   = %q{WebHook provides a nice Ruby DSL for making and triggering WebHooks}
  #spec.homepage      = 'http://www.webhooked.io'
  spec.files         = Dir.glob('lib/**/*')
  spec.license       = 'MIT' #FIXME
  spec.require_paths = ['lib']

  spec.add_dependency('faraday', '~> 0.9')

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rspec-its', '~> 1'
  spec.add_development_dependency 'pry', '~> 0'
  spec.add_development_dependency 'webmock', '~> 1'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0'
end
