class AllowNullUserIdInForumModels < ActiveRecord::Migration[7.1]
  def change
    change_column_null :forum_threads, :user_id, true
    change_column_null :forum_posts, :user_id, true
  end
end
