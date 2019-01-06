class Game < ApplicationRecord
  belongs_to :contest
  belongs_to :stage
  has_many :participations, dependent: :delete_all
  has_many :teams, through: :participations

  default_scope { order(created_at: :desc) }

  accepts_nested_attributes_for :participations

  validate :game_should_not_draw

  def play(draw = true)
    unique_score = (0...10).to_a.shuffle

  	participations.each_with_index do |p, i|
      score = draw ? random_score : unique_score[i]
      p.update(score: score)
    end

    update(played: true)
  end

  def won_participation
    participations.select{ |p| p.won }.first
  end

  private

  def game_should_not_draw
    return unless played
    if !stage.stage_group? && !won_participation
      errors.add(:game, "Result can not be a draw") 
    end
  end

  def random_score
    Random.rand(0...10)
  end
end