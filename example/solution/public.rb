#!/usr/local/bin/ruby

require "minitest/autorun"
require_relative "point.rb"

class PublicTests < MiniTest::Test
  
  def setup
    @p1 = Point.new(10,20)
    @p2 = Point.new(0,0)

  end
  
  def test_x
    assert_equal(10, @p1.x)
    assert_equal(10,@p2.x)
  end
  def test_y
    assert_equal(20, @p1.y)
    assert_equal(0,@p2.y)
  end
end
