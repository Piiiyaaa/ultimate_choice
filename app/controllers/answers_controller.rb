class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  before_action :ensure_not_answered, only: [:create]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question, notice: 'Good vote!'
    else
      @answer.build_comment if @answer.comment.nil?  # コメントフォームのためのインスタンスを作成
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:choice, comment_attributes: [:content])  # コメントのパラメータを許可
  end

  def ensure_not_answered
    if current_user.answers.exists?(question: @question)
      redirect_to @question, alert: 'もう回答してるよ！'
    end
  end
end
