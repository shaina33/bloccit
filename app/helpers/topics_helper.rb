module TopicsHelper
    def user_can_create_delete?
        current_user && current_user.admin?
    end
    def user_can_update?
        user_can_create_delete? || current_user.moderator?
    end
end
