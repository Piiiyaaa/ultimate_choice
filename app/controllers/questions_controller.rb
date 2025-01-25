class QuestionsController < ApplicationController
  # ログインしていないユーザーがアクセスできるアクションを制限
  before_action :authenticate_user!, except: [:index, :show]

  # 指定したアクションで、@question に対象の質問データをセットする
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # 指定したアクションで、現在ログインしているユーザーが対象の質問を所有しているか確認
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    # 質問を作成日時が新しい順に取得
    @questions = Question.all.order(created_at: :desc)
  end

  # 質問の詳細を表示するアクション
  def show
    # 新しい回答オブジェクトを作成（回答フォーム用）
    @answer = Answer.new
    # 現在のユーザーがこの質問に対して投稿した回答を取得（あれば表示するため）
    @user_answer = current_user&.answers&.find_by(question: @question)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to questions_path, notice: '質問を投稿しました'
    else
      flash.now[:alert] = @question.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  # 質問編集フォームを表示するアクション
  def edit
    # @question は before_action :set_question によってセット済み
  end

  # 質問を更新するアクション
  def update
    if @question.update(question_params)
      # 更新に成功した場合、詳細画面にリダイレクト
      redirect_to @question, notice: '質問を更新しました'
    else
      # 更新に失敗した場合、編集フォームを再表示
      render :edit, status: :unprocessable_entity
    end
  end

  # 質問を削除するアクション
  def destroy
    # 質問を削除
    @question.destroy
    # 質問一覧画面にリダイレクト
    redirect_to questions_path, notice: '質問を削除しました'
  end

  private

  # 指定された ID の質問を取得し、@question にセットする
  def set_question
    @question = Question.find(params[:id])
  end

  # 許可するパラメータを指定
  def question_params
    params.require(:question).permit(:choice_one, :choice_two, :choice_one_image, :choice_two_image)
  end

  # 現在のユーザーがこの質問を所有しているか確認
  def ensure_correct_user
    unless @question.user == current_user
      # 所有していない場合、質問一覧画面にリダイレクト
      redirect_to questions_path, alert: '権限がありません'
    end
  end
end