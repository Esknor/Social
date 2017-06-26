class CreateAdvertisings < ActiveRecord::Migration
  def change
    create_table :advertisings do |t|
      t.attachment :img
      t.string :header
      t.text :content

      t.timestamps null: false
    end
    create_join_table :advertisings, :groups
  end
end
