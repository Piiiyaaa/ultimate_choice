class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_one :comment, dependent: :destroy

  validates :choice, presence: true
  validates :user_id, uniqueness: { scope: :question_id, message: "既にこの質問に回答しています" }
  validate :choice_must_be_valid

  private

  def choice_must_be_valid
    unless [question.choice_one, question.choice_two].include?(choice)
      errors.add(:choice, "選択肢から選んでください")
    end
  end
end
