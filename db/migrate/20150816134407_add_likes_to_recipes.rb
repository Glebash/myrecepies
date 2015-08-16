class AddLikesToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :total_likes, :integer
    add_column :recipes, :total_dislikes, :integer
  end
end
