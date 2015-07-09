class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :body
      t.references :question, :user

      t.timestamps null: false
    end
  end
end
