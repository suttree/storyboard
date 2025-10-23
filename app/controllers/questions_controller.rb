class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.all.includes(:question_responses)
  end
end
