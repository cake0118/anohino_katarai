class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|

      t.integer :creator_id, null: false
      t.integer :game_id, null: false
      t.string :title, null: false, default: ""

      t.timestamps
    end
  end
end
