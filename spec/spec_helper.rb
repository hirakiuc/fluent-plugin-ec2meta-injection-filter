$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'webmock/rspec'

require 'fluent/test'
require 'fluent/plugin/filter_ec2meta_injection'

# Disable Test::Unit
module Test::Unit::RunCount; def run(*); end; end

# refs https://github.com/grosser/parallel_tests/issues/189
Test::Unit::AutoRunner.need_auto_run = false if defined?(Test::Unit::AutoRunner)

path = Pathname.new(Dir.pwd)
Dir[path.join('spec/support/**/*.rb')].map { |f| require f }

RSpec.configure do |config|
  config.before(:all) do
    Fluent::Test.setup
  end

  config.order = :random
  Kernel.srand config.seed
end
