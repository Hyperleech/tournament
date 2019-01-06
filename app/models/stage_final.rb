class StageFinal < Stage

	STAGE_TYPE = 'Final'
	
	private

	def init_schedule
		contest.semi_stage.games.each do |game|
			teams << game.won_participation.team
		end
		Game.create(stage_id: id, contest_id: contest_id, teams: [teams.first, teams.last])
	end

	def set_defaults
		self.stage_type = STAGE_TYPE
	end
end
