class StageQuarter < Stage

	STAGE_TYPE = 'Quarter Finals'

	private

	def init_schedule
		teams_array = []

		contest.group_stages.each_with_index do |group, i|
			teams_array[i] = group.sorted_teams[0..3]
		end

		teams_array[0].reverse.zip(teams_array[1]).each do |one, two|
			teams << one
			teams << two
			Game.create(stage_id: id, contest_id: contest_id, teams: [one, two])
		end
	end

	def set_defaults
		self.stage_type = STAGE_TYPE
	end
end
