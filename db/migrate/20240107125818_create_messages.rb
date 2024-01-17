class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.integer :room_id, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
