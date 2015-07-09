class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, null:false
      t.string :body, null:false
      t.integer :view_count, null:false
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
