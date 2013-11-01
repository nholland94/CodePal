module ApplicationHelper
	def add_flash(type, message)
		flash[type] = flash[type] || []
		flash[type] << message
	end
end
