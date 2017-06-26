class Advertising < ActiveRecord::Base
	has_attached_file :img
	validates_attachment_content_type :img, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_and_belongs_to_many :groups
end
