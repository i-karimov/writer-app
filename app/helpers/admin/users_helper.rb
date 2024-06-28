# frozen_string_literal: true

module Admin
  module UsersHelper
    def user_roles
      User.roles.keys.map do |role|
        [role.titleize, role]
      end
    end

    def authored_as_admin_by?(current_user, post)
      post.authored_by?(current_user) && current_user.admin_role?
    end
  end
end
