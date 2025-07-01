- Add gems

  - devise
  - development:
    - annotate
    - better_errors
    - binding_of_caller

  annotate config:

  ```bash
  rails g annotate:install
  ```

- Generate models

  - Generate ForumThread model

    ```bash
    rails generate model ForumThread subject:string user:references
    ```

  - Generate ForumPost model

  ```bash
   rails g model ForumPost body:text forum_thread:references user:references
  ```

- Add associations in models

  - In `app/models/user.rb`:
    ```ruby
    # User can have many forum threads and posts
    # When user is deleted, set user_id to null instead of deleting posts/threads
    has_many :forum_threads, dependent: :nullify
    has_many :forum_posts, dependent: :nullify
    ```
  - In `app/models/forum_thread.rb`:
    ```ruby
    # Forum thread belongs to a user (optional to allow orphaned threads)
    belongs_to :user, optional: true
    # Forum thread can have many posts, destroy posts when thread is deleted
    has_many :forum_posts, dependent: :destroy
    ```
  - In `app/models/forum_post.rb`:
    ```ruby
    # Forum post belongs to a user (optional to allow orphaned posts)
    belongs_to :user, optional: true
    # Forum post must belong to a forum thread
    belongs_to :forum_thread
    ```

- Allow null user_id in forum models (to preserve posts when users are deleted)

  Generate migration to allow null user_id:

  ```bash
  rails generate migration AllowNullUserIdInForumModels
  ```

  Add to migration file:

  ```ruby
  def change
    # Allow user_id to be null in forum_threads table
    change_column_null :forum_threads, :user_id, true
    # Allow user_id to be null in forum_posts table
    change_column_null :forum_posts, :user_id, true
  end
  ```

  Run migration:

  ```bash
  rails db:migrate
  ```
