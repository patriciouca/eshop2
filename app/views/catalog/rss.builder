xml.instruct!
xml.rss "version" => "2.0", 
"xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
	xml.channel do
		xml.title @page_title
		xml.description "BuyFilms: Films on Rails"
		xml.link url_for :action => 'index', :only_path => false
		xml.language "en-us"
		xml.ttl "60"
			for movie in @movies do
			xml.item do
			xml.title movie.title
			xml.description "#{movie.title} by #{movie.director_names}"
			xml.link url_for :action => "show", :id => movie, 
			:only_path => false
			xml.guid url_for :action => "show", :id => movie, 
			:only_path => false
			xml.pubDate movie.created_at.to_s :long
			xml.director movie.director_names
			end
		end
	end
end
