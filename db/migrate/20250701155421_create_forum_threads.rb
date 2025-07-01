class CreateForumThreads < ActiveRecord::Migration[7.1]
  def change
    create_table :forum_threads do |t|
      t.string :subject
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
