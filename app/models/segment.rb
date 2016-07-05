class Segment < ApplicationRecord
	validates_with SegmentValidator, field: :query
	validates :name, format: {
		with: /\A[a-zA-Z_][a-zA-Z0-9_]*\z/
	}
end
