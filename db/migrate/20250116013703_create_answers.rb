class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :choice, null: false

      t.timestamps
    end

    add_index :answers, [:user_id, :question_id], unique: true
  end
end
