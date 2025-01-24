class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :answering_users, through: :answers, source: :user

  validates :choice_one, :choice_two, presence: true

  def answered_by?(user)
    answers.exists?(user: user)
  end
end
