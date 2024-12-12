class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|

      t.integer :user_id, null: false, default: ""
      t.integer :headware_id, null: false, default: ""
      t.string :title, null: false, default: ""
      t.text :body, null: false, default: ""

      t.timestamps
    end
  end
end
