class Question < ApplicationRecord
  mount_uploader :choice_one_image, ChoiceImageUploader
  mount_uploader :choice_two_image, ChoiceImageUploader
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :answering_users, through: :answers, source: :use

  validates :choice_one, :choice_two, presence: true
  validates :title, presence: true 

  def answered_by?(user)
    answers.exists?(user: user)
  end
end
