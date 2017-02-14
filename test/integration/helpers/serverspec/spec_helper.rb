# encoding: utf-8
require 'serverspec'
require 'platform_helpers'

set :backend, :exec

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end # config.expect_with
end # RSpec
