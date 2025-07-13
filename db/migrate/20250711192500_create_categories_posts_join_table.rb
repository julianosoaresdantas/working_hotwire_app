class CreateCategoriesPostsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :posts do |t|
      # Optional: Add indexes for better performance, especially on large datasets.
      t.index [:category_id, :post_id]
      t.index [:post_id, :category_id]
    end
  end
end
