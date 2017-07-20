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


end
