class User < ActiveRecord::Base
	has_one :userinfo ,dependent: :destroy
	has_many 	:posts
	has_many(:own_groups,dependent: :destroy,
				:class_name => "Group",
				:foreign_key => "user_id")
	has_many(:send_messages,dependent: :destroy,
				:class_name => "Message",
				:foreign_key => "sender")
	has_many(:received_messages,dependent: :destroy,
				:class_name => "Message",
				:foreign_key => "receiver")
	has_and_belongs_to_many(:users,
						    :join_table => "friends",dependent: :destroy,
						    :foreign_key => "user_a_id",on_delete: :cascade,
						    :association_foreign_key => "user_b_id",on_delete: :cascade)
	has_and_belongs_to_many(:groups,dependent: :destroy,
						    :join_table => "usersingroups",
						    :foreign_key => "user_id",on_delete: :cascade,
						    :association_foreign_key => "group_id",on_delete: :cascade)

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 4 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
		def create_remember_token
			self.remember_token ||= User.encrypt(User.new_remember_token)
		end
end
