# app/controllers/questions_controller.rb
class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @answer = Answer.new
    @user_answer = current_user&.answers&.find_by(question: @question)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to @question, notice: '質問を投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: '質問を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: '質問を削除しました'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:choice_one, :choice_two)
  end

  def ensure_correct_user
    unless @question.user == current_user
      redirect_to questions_path, alert: '権限がありません'
    end
  end
end
