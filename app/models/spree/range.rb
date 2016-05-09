# BRAND
# Brand represent an entity for sale in a store.

module Spree
  class Range < Spree::Base
    validates :name, :description, :available_on, presence: true
    has_attached_file :image
    validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

    # use deleted? rather than checking the attribute directly. this
    # allows extensions to override deleted? if they want to provide
    # their own definition.
    def deleted?
      !!deleted_at
    end

    # determine if brand is available.
    # deleted brands and brands with nil or future available_on date
    # are not available
    def available?
      !(available_on.nil? || available_on.future?) && !deleted?
    end

    # determine if brand is active.
    # deleted brands and brands with nil or future available_on date
    # are not active
    def active?
      active == true ? Spree.t(:active) : Spree.t(:disabled)
    end

    def range_image
      !image.file? && range.present? && range.images.any? ? range.images.first.attachment : image
    end

  end
end

require_dependency 'spree/product/scopes'