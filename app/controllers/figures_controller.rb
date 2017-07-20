require 'pry'

class FiguresController < ApplicationController

# /figures, to show all figures (no form)
# /figures/new to create new figure, with title, landmark (neeed post request)
# need check boxes for landmarks, titles on figures new page
# /figures/:id, see a single figure (neeed post request)
# /figures/:id/edit (neeed post request)

	get '/figures' do
		@figures = Figure.all
		erb :'figures/index'
	end

	get '/figures/new' do
		@landmarks = Landmark.all
		@titles = Title.all
		erb :'figures/new'
	end

	get '/figures/:id' do
		# binding.pry
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	post '/figures' do
		# {figure: {name: '...', land_mark_ids: [2,4,6], title_ids: [1,2]}}
		@figure = Figure.create(name: params[:figure][:name])
		if !params["landmark"]["name"].empty?
			@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
		else
			#params[:figure]["landmark_ids"] gets a value from the checkboxes
			#so if the checkboxes weren't filled out, the value will be nil
			@figure.landmark_ids=(params[:figure]["landmark_ids"])
		end
		# will add in year_built form, and logic
		if !params["title"]["name"].empty?
			@figure.titles << Title.create(name: params["title"]["name"])
		else
			@figure.title_ids=(params[:figure]["title_ids"])
		end
		# binding.pry
		@figure.save
		redirect "/figures/#{@figure.id}"
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		@landmarks = Landmark.all
		@titles = Title.all
		erb :'figures/edit'
	end

	patch '/figures/:id' do
		# binding.pry
		@figure = Figure.find(params[:id])
		# binding.pry
		@figure.update(params["figure"])
		if !params["landmark"]["name"].empty?
    	@figure.landmarks << Landmark.create(name: params["landmark"]["name"])
		else
			@figure.landmark_ids=(params[:figure]["landmark_ids"])
		end
		if !params["title"]["name"].empty?
			@figure.titles << Title.create(name: params["title"]["name"])
		else
			@figure.title_ids=(params[:figure]["title_ids"])
		end
		redirect "/figures/#{@figure.id}"
	end



end
