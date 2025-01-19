class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :choice_one
      t.string :choice_two

      t.timestamps
    end
  end
end
