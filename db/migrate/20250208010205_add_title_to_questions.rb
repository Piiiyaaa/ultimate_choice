class AddTitleToQuestions < ActiveRecord::Migration[7.0]
  def up
    # まず制約なしでカラムを追加
    add_column :questions, :title, :string
    
    # 既存のレコードにデフォルト値を設定
    # choice_oneとchoice_twoを組み合わせてタイトルとする
    Question.find_each do |question|
      question.update_column(:title, "#{question.choice_one}と#{question.choice_two}")
    end
    
    # その後、NOT NULL制約を追加
    change_column_null :questions, :title, false
  end

  def down
    remove_column :questions, :title
  end
end