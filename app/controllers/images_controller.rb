=begin
Mishal Zaman - July, 2016

A small web page app that retrieves images taken by NASA's
Mars Rovers and displays them. 

API:
https://api.nasa.gov/api.html#MarsPhotos
=end

require 'net/http'

class ImagesController < ApplicationController
  	def index
  	end

  	def create
  		images_rover = ImagesRover.new(params[:image][:sol], params[:image][:rover])
  		data = []
  		result = false

  		data = images_rover.get_images

  		if data.count != 0
  			result = true
  		end

		# Return json output back to request
		respond_to do |format| 
	  		# format.json { render :json => { :images => data, :result => result } }
	  		format.json { render :json => { 
	  			:images => data, 
	  			:result => result,
	  			:retrieval => images_rover.retrieved_images_from
	  		}}
		end
  	end
end
