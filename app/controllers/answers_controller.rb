class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    params.fetch(:answers, {}).each do |question_id, question_response_id|
      answer = Answer.find_or_initialize_by(user: current_user, question_id: question_id)
      answer.question_response_id = question_response_id
      answer.save!
    end
    redirect_to root_path, notice: "Thank you for your responses."
  end
end
