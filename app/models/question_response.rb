class QuestionResponse < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :restrict_with_exception

  validates :text, presence: true
end
