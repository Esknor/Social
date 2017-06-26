class OneToOne < ActiveRecord::Migration
  def change
  	add_reference :users, :userinfo, index: true, foreign_key: true
  	add_reference :userinfos, :user, index: true, foreign_key: true
  end
end
