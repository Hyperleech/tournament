class ContestsController < ApplicationController
	def new
		@contest = Contest.new
		16.times { @contest.teams.build }
	end

	def create
		@contest = Contest.new(safe_params)

	    if @contest.save
	  		redirect_to @contest
	  	else
	  		render :new
	  	end
	end

	def show
		@contest = Contest.find(params[:id])
		@contest.reload if @contest.check_if_create_next_stage
	end

	def destroy
	    @contest = Contest.find(params[:id])
	    @contest.destroy

	    if Contest.any?
	    	redirect_to contests_path
	    else
			redirect_to root_path
	    end
  	end

  	def index
  		@contests = Contest.all
  	end

 	private

	def safe_params
		params.require(:contest).permit(:title, teams_attributes: [:title])
	end
end