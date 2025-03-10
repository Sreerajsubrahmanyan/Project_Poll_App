class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :option

  validates :user_id, uniqueness: { scope: :option_id, message: "can only vote once per poll" }
  validate :user_can_vote_only_once_per_poll

  private

  def user_can_vote_only_once_per_poll
    if Vote.joins(:option).where(user_id: user_id, options: { poll_id: option.poll_id }).exists?
      errors.add(:user_id, "can only vote once per poll")
    end
  end
end
