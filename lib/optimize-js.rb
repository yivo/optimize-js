# encoding: utf-8
# frozen_string_literal: true

require 'execjs'

module OptimizeJS
  class << self
    def perform(js, options = {})
      @optimize_js ||= ExecJS.runtime.compile(js_path)
      raise OptimizeJS::CompileError unless @optimize_js
      @optimize_js.call(js_function, js, options)
    end

    def js_path
      File.read(File.expand_path('../optimize-js.web.min.js', File.dirname(__FILE__)))
    end

    def js_function
      'optimizeJS'
    end
  end

  class CompileError < StandardError

  end
end

require 'optimize-js/railtie' if defined?(Rails)
