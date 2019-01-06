class StageGroup < Stage

	STAGE_TYPE = 'Division'
	
	private

	def init_schedule
		teams.to_a.combination(2).to_a.each do |pair|
			Game.create(stage_id: id, contest_id: contest_id, teams: pair)
		end
	end

	def set_defaults
		self.stage_type = STAGE_TYPE
	end
end
