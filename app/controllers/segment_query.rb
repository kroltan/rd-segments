module SegmentQuery
	def self.from_json model, json_query
		query = JSON.parse json_query
		self.from_tree model, query
	end

	def self.from_tree model, query
		op = SegmentQuery::Operators[query["op"]]

		if query["args"].count != op[:args]
			raise ArgumentError.new "wrong argument count for #{query["op"]}"
		end

		arel_table = model.arel_table

		op[:op].call arel_table, query["args"].map { |arg|
			if arg.is_a? Hash
				arel_table.grouping(self.from_tree model, arg)
			else
				arg
			end
		}
	end
end

module SegmentQuery::Helpers
	def self.glue args, &block
		args.drop(1).reduce(args.first) { |q, item|
			yield q, item
		}
	end

	def self.matches args, pre, post
		# backslashes: 4 first are literal backslash
		# then capture group 0 (the percent sign)
		escaped_fmt = args.last.gsub "%", "\\\\\\0"
		args.first.matches "#{pre}#{escaped_fmt}#{post}"
	end
end

SegmentQuery::Operators = {
	# access operators
	"field" => {
		args: 1,
		op: -> (table, args) {
			table[args.first]
		}
	},

	# comparsion operators
	"eq" => {
		args: 2,
		op: -> (table, args) {
			args.first.eq(args.last)
		}
	},

	"lt" => {
		args: 2,
		op: -> (table, args) {
			args.first.lt(args.last)
		}
	},
	"gt" => {
		args: 2,
		op: -> (table, args) {
			args.first.gt(args.last)
		}
	},
	"lte" => {
		args: 2,
		op: -> (table, args) {
			args.first.lteq(args.last)
		}
	},
	"gte" => {
		args: 2,
		op: -> (table, args) {
			args.first.gteq(args.last)
		}
	},
	"in" => {
		args: "*",
		op: -> (table, args) {
			args.first.in(args)
		}
	},

	# boolean operators
	"all" => {
		args: "+",
		op: -> (table, args) {
			SegmentQuery::Helpers.glue args {|q, item|
				q.and(item)
			}
		}
	},
	"any" => {
		args: "+",
		op: -> (table, args) {
			SegmentQuery::Helpers.glue args {|q, item|
				q.or(item)
			}
		}
	},
	"not" => {
		args: 1,
		op: -> (table, args) {
			args.first.not
		}
	},

	# string operators
	"contains" => {
		args: 2,
		op: -> (table, args) {
			SegmentQuery::Helpers.matches args, "%", "%"
		}
	},
	"starts_with" => {
		args: 2,
		op: -> (table, args) {
			SegmentQuery::Helpers.matches args, "", "%"
		}
	},
	"ends_with" => {
		args: 2,
		op: -> (table, args) {
			SegmentQuery::Helpers.matches args, "%", ""
		}
	}
}