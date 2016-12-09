# encoding: utf-8
# frozen_string_literal: true

require 'optimize-js/sprockets-processor'

class OptimizeJS::Railtie < Rails::Railtie
  def configure_assets(app)
    if config.respond_to?(:assets) && config.assets.respond_to?(:configure)
      # Rails 4.x, 5.x
      config.assets.configure { |env| yield(env) }
    else
      # Rails 3.2
      yield(app.assets)
    end
  end

  initializer 'sprockets.optimize_js', group: :all, after: 'sprockets.environment' do |app|
    configure_assets(app) do |env|
      # Sprockets 2, 3, and 4
      env.register_bundle_processor 'application/javascript', OptimizeJS::SprocketsProcessor
    end
  end
end
