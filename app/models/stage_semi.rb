class StageSemi < Stage

	STAGE_TYPE = 'Semi Finals'

	private

	def init_schedule
		contest.quarter_stage.games.each do |game|
			teams << game.won_participation.team
		end

		teams.each_slice(2).to_a.each do |pair|
			Game.create(stage_id: id, contest_id: contest_id, teams: pair)
		end
	end

	def set_defaults
		self.stage_type = STAGE_TYPE
	end
end
