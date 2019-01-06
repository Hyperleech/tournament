class GamesController < ApplicationController

	def edit
		@game = Game.find(params[:id])
	end

	def update
		@game = Game.find(params[:id])

  		if @game.update(update_params)
  			flash[:success] = "score saved!"
  			redirect_to @game.contest
  		else
  			render :edit
  		end
  	end

 	private

	def safe_params
		params.require(:game).permit(participations_attributes: [:id, :score])
	end

	def update_params
		uparams = safe_params
		uparams[:played] = true
		uparams
	end
end
