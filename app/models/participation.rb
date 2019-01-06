class Participation < ApplicationRecord
	belongs_to :team
	belongs_to :game

	validates_numericality_of :score

	def won
		return unless played
		score > opposition_score
	end

	def lost
		return unless played
		score < opposition_score
	end

	def draw
		return unless played
		score == opposition_score
	end

	def played
		game.played
	end

	def opposition_score
		opposition.score
	end

	def points
		if won
			3
		elsif draw
			1
		else
			0
		end
	end

	def opposition
		game.participations.select{|x| x.team_id != team_id }.first
	end 
end
