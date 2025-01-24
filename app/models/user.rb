class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:name]

  validates :name, presence: true, uniqueness: true
  
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
end