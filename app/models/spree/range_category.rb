module Spree
  class RangeCategory < Spree::Base
    delegate_belongs_to :ranges
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
    has_attached_file :image
    validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

    validates :name, :description, presence: true

    def range_category_image
      !image.file? && range_category.present? && range_category.images.any? ? range_category.images.first.attachment : image
    end
  end
end