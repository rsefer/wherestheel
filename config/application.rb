require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wherestheel
  class Application < Rails::Application
    config.time_zone = 'America/Chicago'
    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 %r{^/(.*)/$}, '/$1'
    end
  end
end
