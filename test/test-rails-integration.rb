# encoding: utf-8
# frozen_string_literal: true

require 'optimize-js'
require 'test/unit'
require 'fileutils'

class RailsIntegrationTest < Test::Unit::TestCase
  def test_registration
    app = create_rails_application
    app.initialize!

    assert app.assets.bundle_processors.key?('application/javascript')
    assert Array === app.assets.bundle_processors['application/javascript']
    assert app.assets.bundle_processors['application/javascript'].include?(OptimizeJS::SprocketsProcessor)
  end

  def test_compilation
    app = create_rails_application
    app.initialize!
    task = create_sprockets_task(app)

    task.instance_exec { manifest.compile(assets) }
    assert_equal app.assets['application.js'].to_s.strip, '!(function() {})();'
  end

  def setup
    super
    clear_tmp
  end

  def teardown
    super
    clear_tmp
    Rails.application = nil if defined?(Rails)
  end

private
  def create_rails_application
    require 'rails'
    require 'sprockets/railtie'
    require 'optimize-js/railtie'

    Class.new(Rails::Application) do
      config.eager_load = false
      config.assets.enabled = true
      config.assets.gzip = false
      config.assets.paths = [Rails.root.join('test/fixtures/javascripts').to_s]
      config.assets.precompile = %w( 'application.js' )
      config.paths['public'] = Rails.root.join('tmp').to_s
    end
  end

  def create_sprockets_task(app)
    require 'sprockets/version' # Fix for sprockets 2.x

    if Sprockets::VERSION.start_with?('2')
      require 'rake/sprocketstask'
      Rake::SprocketsTask.new do |t|
        t.environment = app.assets
        t.output      = "#{app.config.paths['public']}#{app.config.assets.prefix}"
        t.assets      = app.config.assets.precompile
      end
    else
      require 'sprockets/rails/task'
      Sprockets::Rails::Task.new(app)
    end
  end

  def clear_tmp
    FileUtils.rm_rf(File.expand_path('../../tmp', __FILE__))
  end
end
