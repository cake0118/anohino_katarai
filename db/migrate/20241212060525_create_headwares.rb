class CreateHeadwares < ActiveRecord::Migration[6.1]
  def change
    create_table :headwares do |t|

      t.string :name, null: false, default: ""

      t.timestamps
    end
  end
end
