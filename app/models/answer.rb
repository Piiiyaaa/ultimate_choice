class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  has_one :comment, dependent: :destroy

  validates :choice, presence: true
  validate :choice_must_be_valid

  private

  def choice_must_be_valid
    unless [question.choice_one, question.choice_two].include?(choice)
      errors.add(:choice, "must be one of the available options")
    end
  end
end
