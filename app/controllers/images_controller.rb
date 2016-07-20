=begin
Mishal Zaman - July, 2016

A small web page app that retrieves images taken by NASA's
Mars Rovers and displays them. 

API:
https://api.nasa.gov/api.html#MarsPhotos
=end

require 'net/http'

class ImagesController < ApplicationController

  	@@API_key = "ei2jMgXuLSMVuvuIZjsNsSUNbLifAEGnZvisPg0K"

  	def index
  	end

  	def create
		query = Image.where(sol: params[:image][:sol], rover: params[:image][:rover])

		if query.count > 0
		  	# Found images on database. Display it instead of making an API request
		  	data = query
		  	result = true
		else
		  	# get API request response
		  	response = request_rover_api

		  	if response == false 
		  		data = false
		  		result = false;
		  	else
		  		data = save_image(response)
		  		result = true
		  	end
		end



		# Return json output back to request
		respond_to do |format| 
	  		# format.json { render :json => { :images => data, :result => result } }
	  		format.json { render :json => { 
	  			:images => data, 
	  			:result => result
	  		}}
		end
  	end

  	def request_rover_api
		url = "https://api.nasa.gov/mars-photos/api/v1/rovers/#{params[:image][:rover]}/photos?sol=#{params[:image][:sol]}&api_key=#{@@API_key}"
		request = Net::HTTP.get_response(URI.parse(url))
		response = JSON.parse(request.body)

		if response.key?('photos')
			return response
		end

		return false
  	end

  	def save_image(data)
		images = []

		data["photos"].each do |image|
			set = {
				:sol          => image['sol'],
				:img_src      => image['img_src'],
				:rover        => image['rover']['name'].downcase,
				:camera_name    => image['camera']['name'],
				:camera_full_name => image['camera']['full_name'],
				:earth_date     => image['earth_date'],
			}

	  		#save to database
	  		@img = Image.create(set)
	  		@img.save

	  		images.push(set)
		end

		return images
  	end

  	private

	  	def image_params
			params.require(:image).permit(:sol, :img_src, :rover, :camera_name, :camera_full_name, :earth_date)
	  	end
end
