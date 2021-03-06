class LandmarksController < ApplicationController

  get '/landmarks' do
		@landmarks = Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/new' do
		@landmarks = Landmark.all
		erb :'landmarks/new'
	end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    # {figure: {name: '...', land_mark_ids: [2,4,6], title_ids: [1,2]}}
		redirect "/landmarks/#{@landmark.id}"
	end

  get '/landmarks/:id/edit' do
		@landmark = Landmark.find(params[:id])
		erb :'landmarks/edit'
	end

  patch '/landmarks/:id' do
		# binding.pry
		@landmark = Landmark.find(params[:id])
		# binding.pry
		@landmark.update(params["landmark"])

		redirect "/landmarks/#{@landmark.id}"
	end


end
