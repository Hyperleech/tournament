class StagesController < ApplicationController
  def auto_generate
  	@stage = Stage.find(params[:id])
  	@stage.auto_generate_games
  	flash[:success] = @stage.name+" results generated!"
  	redirect_to @stage.contest
  end
end
