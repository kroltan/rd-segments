require 'test_helper'

class SegmentsHelperTest < ActionView::TestCase
	include SegmentsHelper
	test "should return an array of operator definitions" do
		result = operators
		assert_kind_of Array, result
		result.each { |op|
			assert_kind_of Hash, op
			assert_kind_of String, op[:name]
			assert_kind_of String, op[:friendly_name]
		}
	end
end