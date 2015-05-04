Gem::Specification.new do |spec|
  spec.name          = 'fluent-plugin-ec2meta-injection-filter'
  spec.version       = '0.0.1'
  spec.authors       = ['daisuke.hirakiuchi']
  spec.email         = ['devops@leonisand.co']

  spec.summary       = 'Filter plugin to add metadata of AWS EC2 instance.'
  spec.description   = 'Filter plugin to add metadata of AWS EC2 instance. This plugin is available only on EC2 instance.'
  spec.homepage      = 'TODO: Put your gem\'s website or public repo URL here.'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'fluentd', '~> 0.12'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'bundler'

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'simplecov', '>= 0.5.4'
end
