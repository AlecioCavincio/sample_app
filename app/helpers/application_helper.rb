module ApplicationHelper

	#return a proper full title on a per-page basis. (in case the given title is empty, we'll never get a useless | bar at the end )
	def full_title(page_title)
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end