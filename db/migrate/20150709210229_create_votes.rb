class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :body, null:false
      t.string :value, null:false
      t.references :user, foreign_key: true
      t.references :voteable, polymorphic: true

      t.timestamps null: false
    end
  end
end
