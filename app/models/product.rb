class Product < ActiveRecord::Base
  validates :title,
    presence: true,
    uniqueness: true

  validates :description,
    presence: true

  validates :image_url,
    presence: true,
    format: {
      with: %r{\.(gif|png|jpg)\Z}i,
      message: "must be a URL for GIF, PGN or JPG image."
    }

  validates :price,
    numericality: { greater_than_or_equal_to: 0.01 }
end
