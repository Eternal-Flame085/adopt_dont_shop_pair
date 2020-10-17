class Review < ApplicationRecord
  belongs_to :shelter
  belongs_to :user
  validates_presence_of :title, :rating, :content

  def self.best_rating(reviews)
    reviews.max_by{|review| review.rating}
  end

  def self.worst_rating(reviews)
    reviews.min_by{|review| review.rating}
  end
end
