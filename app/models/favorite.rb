class Favorite < ApplicationRecord
  validates :yelp_id, presence: true

  # This would likely use a join table to associate multiple users with multiple favorites
end
