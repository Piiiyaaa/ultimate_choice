class Question < ApplicationRecord
  mount_uploader :choice_one_image, ChoiceImageUploader
  mount_uploader :choice_two_image, ChoiceImageUploader
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :answering_users, through: :answers, source: :use

  validates :choice_one, :choice_two, presence: true
  validates :title, presence: true 

  scope :order_by_answer_count, -> do
    sql = <<~SQL
      LEFT OUTER JOIN (
        SELECT a.question_id, COUNT(*) AS cnt
        FROM answers a
        GROUP BY a.question_id
      ) answer_counts
      ON answer_counts.question_id = questions.id
    SQL

    joins(sql)
      .order(Arel.sql("COALESCE(answer_counts.cnt, 0) DESC"))
  end

  def answered_by?(user)
    answers.exists?(user: user)
  end
end
