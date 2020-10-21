class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pet_count
    pets.count
  end

  def average_rating
    review_total = 0
    if reviews.count > 0
      reviews.each do |review|
        review_total += review.rating
      end
      review_total/reviews.count
    end
  end

  def applications_count
    applications = []
    pets.each do |pet|
      applications << pet.applications
    end
    applications.flatten.uniq.count
  end

  def pending_applications?
    any_pending = false

    pets.each do |pet|
      pet.applications.each do |application|
        any_pending = true if application.status == 'Pending'
      end
    end
    any_pending
  end

  def deletable?
    total_applications = 0
    total_approved = 0
    can_delete = true

    pets.each do |pet|
      pet.applications.each do |application|
        total_applications += 1
        total_approved += 1 if application.status == 'Approved'
      end
    end
    
    can_delete = false if total_approved == total_applications && total_applications > 0
    can_delete
  end
end
