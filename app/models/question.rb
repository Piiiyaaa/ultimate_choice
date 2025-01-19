class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :choice_one, :choice_two, presence: true
end
