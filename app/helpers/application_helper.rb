module ApplicationHelper
	def nav_to body = nil, url = nil, **options
		link_to body, url, options.merge({
			class: ([options[:class]] + [:button]).flatten
		})
	end

	def pretty_json json_string
		if json_string
			JSON.pretty_generate JSON.parse json_string
		end
	end
end
