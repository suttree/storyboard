class Question < ApplicationRecord
  has_many :question_responses, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :text, presence: true

  default_scope { order(position: :asc) }
end
