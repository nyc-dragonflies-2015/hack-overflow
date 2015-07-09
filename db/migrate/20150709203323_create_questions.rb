class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :body
      t.string :view_count
      t.references :user

      t.timestamps null: false
    end
  end
end
