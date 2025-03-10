class Poll < ApplicationRecord
  belongs_to :user
  has_many :options, dependent: :destroy
  has_many :votes, through: :options, dependent: :destroy
  validates :question, presence: true
end
