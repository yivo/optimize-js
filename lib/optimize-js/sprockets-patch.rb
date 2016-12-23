def OptimizeJS.patch_sprockets_js_compressor(base)
  base.instance_exec do
    alias_method :original_js_compressor=, :js_compressor=

    define_method :js_compressor= do |compressor|
      unregister_bundle_processor 'application/javascript', OptimizeJS::SprocketsProcessor
      send(:original_js_compressor=, compressor)
      register_bundle_processor 'application/javascript', OptimizeJS::SprocketsProcessor
    end
  end
end

begin
  require 'sprockets/compressing'
  OptimizeJS.patch_sprockets_js_compressor Sprockets::Compressing
rescue LoadError
  require 'sprockets/processing'
  OptimizeJS.patch_sprockets_js_compressor Sprockets::Processing
end
