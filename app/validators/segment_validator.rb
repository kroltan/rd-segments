class SegmentValidator < ActiveModel::Validator
	def validate segment
		if options[:field]
			validate_query segment, segment.send(options[:field])
		end
		if options[:fields]
			options[:fields].each { |f|
				validate_query segment, segment.send(f)
			}
		end
	end

	def validate_query model, query
		if not query
			model.errors.add(:query, "cannot be empty")
			return
		end

		begin
			validate_condition model, JSON.parse(query)
		rescue JSON::ParserError => e
			model.errors.add(:query, e.to_s)
		end
	end

	private
	def validate_condition record, condition
		operation = condition["op"]
		arguments = condition["args"]

		if operation_exists record, operation
			arguments_valid record, operation, arguments
		end
	end

	def operation_exists record, operation
		if operation.is_a? String
			# whitelist operators
			if not SegmentQuery::Operators.keys.any? {|op| op.to_s == operation }
				record.errors.add(
					:query,
					"unsupported operation '#{operation}'"
				)
				return false
			end
		else
			record.errors.add(:query, "operation must be a string")
			return false
		end
		
		return true
	end

	def arguments_valid record, operation, arguments
		if not arguments.is_a? Array
			record.errors.add(:query, "arguments must be an array")
			return
		end

		arg_count = SegmentQuery::Operators[operation][:args]

		if arg_count
			# one or more
			if arg_count == "+" && arguments.count < 1
				record.errors.add(
					:query,
					"#{operation} requires at least one parameter"
				)
			end

			# specific number
			if arguments.count != arg_count
				record.errors.add(
					:query,
					"#{operation} expects #{arg_count}" +
					" arguments, got #{arguments.count}"
				)
			end
		end

		arguments.each do |arg|
			if arg.is_a? Hash
				validate_condition record, arg
			end
		end
	end
end