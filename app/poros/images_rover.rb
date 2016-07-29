class ImagesRover
	def initialize(sol, rover)
		@api_key = "ei2jMgXuLSMVuvuIZjsNsSUNbLifAEGnZvisPg0K"
		@sol = sol
		@rover = rover
		@retrieval = ""
	end

  	def get_images
  		data = []
  		@retrieval = ""

  		data = Image.where(:sol => @sol, :rover => @rover)

  		# Check if the model query returned any records.
  		# If so, then we do not need to make an API request
  		if data.count > 0
  			@retrieval = "database"
  			return data
  		end

  		# Images were not found in the database.
  		# Therefore, Make an API request
  		data = request_rover_api

  		if data.count > 0
  			@retrieval = "API"
  			# save to Images database
  			images = save_image(data)

  			if images.count > 0
  				return images
  			else
  				return data
  			end
  		end

  		return data = []
  	end

  	def retrieved_images_from
  		return @retrieval
  	end

  	private

  	# Creates a request to NASA's Mars photos API by sol date and rover name
  	# The API returns a JSON object with index 'photos', if photos are found.
  	# If any photos aren't found, it would return an 'error' index
  	def request_rover_api
		url = "https://api.nasa.gov/mars-photos/api/v1/rovers/#{@rover}/photos?sol=#{@sol}&api_key=#{@api_key}"
		request = Net::HTTP.get_response(URI.parse(url))
		response = JSON.parse(request.body)

		if response.key?('photos')
			return response
		end

		return response = []
  	end

  	# Save images gathered from the API request in to the database
  	def save_image(data)
		images = []

		data["photos"].each do |image|
			set = {
				:sol              => image['sol'],
				:img_src          => image['img_src'],
				:rover            => image['rover']['name'].downcase,
				:camera_name      => image['camera']['name'],
				:camera_full_name => image['camera']['full_name'],
				:earth_date       => image['earth_date'],
			}

	  		#save to database
	  		img = Image.create(set)
	  		img.save

	  		images.push(set)
		end

		return images
  	end
end