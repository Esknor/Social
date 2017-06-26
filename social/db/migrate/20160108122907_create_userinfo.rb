class CreateUserinfo < ActiveRecord::Migration
  def change
    create_table :userinfos do |t|
      t.string :firstname
      t.string :lastname
      t.string :status
      t.string :permission
      t.attachment :userinfos, :avatar

      t.timestamps null: false
    end
  end
end
