class Group < ActiveRecord::Base
	has_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	belongs_to(:owner,
				:class_name => "User",
				:foreign_key => "user_id")
	has_and_belongs_to_many(:users,dependent: :destroy,
						    :join_table => "usersingroups",
						    :foreign_key => "group_id",
						    :association_foreign_key => "user_id")
	has_many :posts ,dependent: :destroy
	has_and_belongs_to_many :advertisings
end
