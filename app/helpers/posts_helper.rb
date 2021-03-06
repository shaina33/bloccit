module PostsHelper
    def user_can_delete?(post)
        current_user && (current_user == post.user || current_user.admin?)
    end
    def user_can_edit?(post)
        current_user && (user_can_delete?(post) || current_user.moderator?)
    end
end
