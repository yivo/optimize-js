# encoding: utf-8
# frozen_string_literal: true

# Sprockets 2, 3 & 4 interface
# https://github.com/rails/sprockets/blob/master/guides/extending_sprockets.md#registering-all-versions-of-sprockets-in-processors
class OptimizeJS::SprocketsProcessor
  def initialize(filename, &block)
    @filename = filename
    @source   = block.call
  end

  def render(context, empty_hash_wtf)
    self.class.run(@filename, @source, context)
  end

  class << self
    def run(filename, source, context)
      OptimizeJS.perform(source)
    end

    def call(input)
      filename = input[:filename]
      source   = input[:data]
      context  = input[:environment].context_class.new(input)

      result = run(filename, source, context)
      context.metadata.merge(data: result)
    end
  end
end
