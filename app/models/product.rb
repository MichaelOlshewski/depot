class Product < ApplicationRecord
  has_one_attached :image

  # This line helps implement real time updates to show changes to clients listening on the right webpage. see index.html.erb in app/views/products/index.html.erb
  after_commit -> { broadcast_refresh_later_to "products" }
end
