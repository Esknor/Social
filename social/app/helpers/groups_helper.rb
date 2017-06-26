module GroupsHelper
	def group_perm
		if current_user.nil?
			return nil
		end
		user = @group.users.where(id: current_user.id).select('users.*, usersingroups.permission as perm').first
		if !user.nil?
			return user.perm
		else
			return nil
		end
	end
end
