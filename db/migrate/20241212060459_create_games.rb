class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|

      t.integer :user_id, null: false
      t.integer :headware_id, null: false
      t.string :title, null: false, default: ""
      t.text :body, null: false

      t.timestamps
    end
  end
end
