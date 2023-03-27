class RemoveRatingReviewsFromProperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :properties, :rating, :float
    remove_column :properties, :reviews, :integer
  end
end
