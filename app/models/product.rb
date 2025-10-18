class Product < ApplicationRecord
  # apply attachments here
  has_one_attached :image

  # validate data here
  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validate :acceptable_image

  # This line helps implement real time updates to show changes to clients listening on the right webpage. see index.html.erb in app/views/products/index.html.erb
  after_commit -> { broadcast_refresh_later_to "products" }

  # Define functions here
  def acceptable_image
    return unless image.attached?

    acceptable_types = [ "image/gif", "image/jpeg", "image/jpg", "image/png" ]

    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPG, or PNG image")
    end
  end
end
