class Contest < ApplicationRecord
	has_many :teams,   dependent: :destroy
	has_many :games,   dependent: :destroy
	has_many :stages,  dependent: :destroy

	accepts_nested_attributes_for :teams

	after_create :create_group_stages

	validates_presence_of :title
	validates :teams, length: { minimum: 16, maximum: 16 }
	validates_associated :teams

	def check_if_create_next_stage
		stage = stages.first
		if stage_finished?(stage.stage_type) && !stage.stage_final?
			create_next_stage(get_next_stage(stage.stage_type))
		end
	end

	def group_stages
		stage_of(StageGroup::STAGE_TYPE)
	end

	def quarter_stage
		stage_of(StageQuarter::STAGE_TYPE).first
	end

	def semi_stage
		stage_of(StageSemi::STAGE_TYPE).first
	end

	def final_stage
		stage_of(StageFinal::STAGE_TYPE).first
	end

	def winner
		return unless final_stage && final_stage.finished?
		final_stage.games.first.won_participation.team.title
	end

	private

	def create_group_stages
		teams.shuffle.in_groups_of(8).each do |team_list|
  			StageGroup.create(contest_id: id, teams: team_list)
		end
	end

	def stage_finished?(stage_type)
		stages.select{|s| s.stage_type == stage_type}.all?{|p| p.finished?} 
	end

	def create_next_stage(next_stage)
		Object.const_get(next_stage).create(contest_id: id)	
	end

	def stage_of(type)
		stages.select{|s| s.stage_type == type}
	end

	def get_next_stage(stage_type)
		case stage_type
		when StageGroup::STAGE_TYPE
		  "StageQuarter"
		when StageQuarter::STAGE_TYPE
		  "StageSemi"
		when StageSemi::STAGE_TYPE
		  "StageFinal"
		else
		  "Stage"
		end
	end
end