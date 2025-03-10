class Option < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
  after_initialize :set_default_votes_count

  def set_default_votes_count
    self.votes_count ||= 0
  end
end
