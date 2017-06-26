class Userinfo < ActiveRecord::Base
	belongs_to :users,dependent: :destroy
	has_attached_file :avatar,dependent: :destroy
	validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
