class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pets_applications, dependent: :destroy
  has_many :applications, through: :pets_applications

  def self.search(search)
    if search
      self.where("name ILIKE ?", "%#{search}%")
    else
      []
    end
  end

  def deletable?
    can_delete = true
    total_approved = 0

    self.applications.each do |application|
      total_approved += 1 if application.status == 'Approved'
    end

    can_delete = false if total_approved > 0
    can_delete
    end
  end
