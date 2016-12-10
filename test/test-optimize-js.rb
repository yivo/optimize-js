# encoding: utf-8
# frozen_string_literal: true

require 'optimize-js'
require 'test/unit'

class OptimizeJSTest < Test::Unit::TestCase
  def test_api
    assert_equal OptimizeJS.perform('!function() {}()'), '!(function() {})()'
    assert_match /optimize-js\.web\.min\.js/, OptimizeJS.js_path
    assert_match /optimize/, OptimizeJS.js_function
  end
end
