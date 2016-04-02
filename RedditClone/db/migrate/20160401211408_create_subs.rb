class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, index: true
      t.string :description
      t.integer :user_id, index: true
      t.timestamps null: false
    end
  end
end
