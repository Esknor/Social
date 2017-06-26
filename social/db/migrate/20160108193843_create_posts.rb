class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content

      t.timestamps null: false
    end
    add_reference :posts,	 :user, index: true, foreign_key: true
    add_reference :posts,	 :group, index: true, foreign_key: true
  end
end
