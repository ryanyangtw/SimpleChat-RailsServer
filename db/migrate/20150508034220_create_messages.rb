class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.text :content
      t.integer :user_id
      t.integer :room_id
      t.timestamps null: false
    end
  end
end
