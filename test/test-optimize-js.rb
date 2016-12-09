# encoding: utf-8
# frozen_string_literal: true

require 'optimize-js'
require 'test/unit'

class OptimizeJSTest < Test::Unit::TestCase
  def test_optimize_js
    assert_equal '!(function() {})()', OptimizeJS.perform('!function() {}()')
  end
end
