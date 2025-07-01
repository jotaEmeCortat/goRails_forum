# == Schema Information
#
# Table name: forum_posts
#
#  id              :bigint           not null, primary key
#  body            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  forum_thread_id :bigint           not null
#  user_id         :bigint
#
# Indexes
#
#  index_forum_posts_on_forum_thread_id  (forum_thread_id)
#  index_forum_posts_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (forum_thread_id => forum_threads.id)
#  fk_rails_...  (user_id => users.id)
#
class ForumPost < ApplicationRecord
  belongs_to :forum_thread
  # Allow user_id to be null, so that if a user is deleted, the post remains
  belongs_to :user, optional: true
end
