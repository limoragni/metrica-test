class LinesController < ApplicationController
	respond_to :json
	ActionController::Parameters.permit_all_parameters = true
	
	def index
		@lines = Line.all
	end

	def create
		data = formatLineData(params)
		@line = Line.new(data) 
		
		@line.save() 
		
		respond_with @line
	end

	def update
		@line = Line.find params[:id]
		data = formatLineData(params)
		
		@line.update(data) 
		respond_with @line
	end

	def destroy
	  @line = Line.find params[:id]
	  @line.destroy
	 
	  respond_with @line
	end

	def formatLineData(data)
		dataToUpdate = params[:line]
		data[:position].each do |p|
			dataToUpdate[:point_a_x] = params[:position][0][:x]
			dataToUpdate[:point_a_y] = params[:position][0][:y]
			dataToUpdate[:point_b_x] = params[:position][1][:x]
			dataToUpdate[:point_b_y] = params[:position][1][:y]
		end
		return dataToUpdate
	end
end