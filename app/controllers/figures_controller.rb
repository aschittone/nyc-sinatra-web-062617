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
		end
		# will add in year_built form, and logic
		if !params["title"]["name"].empty?
			@figure.titles << Title.create(name: params["title"]["name"])
		end
		# binding.pry
		@figure.save
		@figure.title_ids=(params[:figure]["title_ids"])
		@figure.landmark_ids=(params[:figure]["landmark_ids"])
		binding.pry
		redirect "/figures/#{@figure.id}"
	end



end
