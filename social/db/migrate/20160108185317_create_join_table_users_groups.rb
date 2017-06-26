class CreateJoinTableUsersGroups < ActiveRecord::Migration
  create_table "usersingroups", :force => true, :id => false do |t|
	  t.integer "user_id", :null => false
	  t.integer "group_id", :null => false
	  t.string "permission"
	end
end