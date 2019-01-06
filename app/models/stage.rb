class Stage < ApplicationRecord
	belongs_to :contest
	has_many :games
	has_and_belongs_to_many :teams

	default_scope { order(created_at: :desc) }

	before_create :set_defaults
	after_create  :init_schedule

	def finished?
		games_to_play.all?{|g| g.played}
	end

	def auto_generate_games
		draw = stage_group? ? true : false
		games_to_play.map{|g| g.play(draw) }
	end

	def stage_group?
		stage_type == StageGroup::STAGE_TYPE
	end

	def stage_final?
		stage_type == StageFinal::STAGE_TYPE
	end

	def name
		return stage_type unless stage_group?
		return "Division A" if contest.group_stages[0].id == id
		"Division B"
	end

	def sorted_teams
		@sorted_teams ||= teams.sort_by(&:group_points).reverse
	end

	private

	def games_to_play
		@games_to_play ||= games.select{|g| !g.played }
	end
end
