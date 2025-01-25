class AddImagesToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :choice_one_image, :string
    add_column :questions, :choice_two_image, :string
  end
end
