class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :describe
      t.boolean :privacy, default: false
      t.attachment :image

      t.timestamps null: false
    end
  end
end
