class AnswersController < ApplicationController
  # ログイン必須
  before_action :authenticate_user!
  # 対象の質問を設定
  before_action :set_question
  # 回答済みでないことを確認
  before_action :ensure_not_answered, only: [:create]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question, notice: 'Good vote!!! haha'
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:choice)
  end

  def ensure_not_answered
    if current_user.answers.exists?(question: @question)
      redirect_to @question, alert: 'もう回答してるよ〜ん'
    end
  end
end
