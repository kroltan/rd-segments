require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
	test "validates name" do
		segment = Segment.new

		assert_not segment.valid?
		assert_includes segment.errors.keys, :name
		assert_includes segment.errors.keys, :query

		segment.name = "some non-identifier name"
		assert_not segment.valid?
		assert_includes segment.errors.keys, :name

		segment.name = "someValid_name"
		segment.validate
		assert_not segment.errors.keys.include?(:name)
	end

	test "validates query" do
		segment = Segment.new

		segment.query = <<-JSON
		{
			"op": "foo",
			"args": []
		}
		JSON
		segment.validate
		assert_includes segment.errors.keys, :query

		segment.query = <<-JSON
		{
			"op": "eq",
			"args": [
				{
					"op": "field",
					"args": ["name"]
				},
				"Mr. Foo"
			]
		}
		JSON
		segment.validate
		assert_not segment.errors.keys.include? :query
	end
end
