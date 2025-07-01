# == Schema Information
#
# Table name: forum_threads
#
#  id         :bigint           not null, primary key
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_forum_threads_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ForumThread < ApplicationRecord
  # If user is deleted, set forum threads to null
  belongs_to :user, optional: true
  has_many :forum_posts, dependent: :destroy
end
