class Team < ApplicationRecord
	belongs_to :contest
	has_many :participations
	has_and_belongs_to_many :stages

	validates :title, presence: true

	def group_games_played
		group_participations.select{|p| p.played }.count
	end

	def group_games_won
		group_participations.select{|p| p.won }.count
	end

	def group_games_lost
		group_participations.select{|p| p.lost }.count
	end

	def group_games_draw
		group_participations.select{|p| p.draw }.count
	end

	def group_goals_scored
		group_participations.map(&:score).inject(0, &:+)
	end

	def group_goals_conceded
		group_participations.map(&:opposition_score).inject(0, &:+)
	end

	def group_points
		group_participations.to_a.inject(0){|sum,p| sum + p.points }
	end

	private

	def group_participations
		@group_participations ||= participations.select{|p| p.played && p.game.stage.stage_group? }
	end
end
