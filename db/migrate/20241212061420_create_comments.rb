class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.integer :user_id, null: false
      t.integer :group_id, null: false
      t.string :body, null: false, default: ""

      t.timestamps
    end
  end
end
