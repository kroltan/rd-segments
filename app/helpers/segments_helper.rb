module SegmentsHelper
	def operators
		SegmentQuery::Operators.map { |k, v|
			{
				name: k,
				friendly_name: I18n.t(k),
				args: v[:args]
			}
		}
	end
end
