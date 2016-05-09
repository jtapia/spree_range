# BRAND
# Brand represent an entity for sale in a store.

module Spree
  class Range < Spree::Base
    validates :name, :start_range, :end_range, :include_range, presence: true
    has_many :range_categories

    # determine if brand is available.
    # deleted brands and brands with nil or future available_on date
    # are not available
    def available?
      !(available_on.nil? || available_on.future?)
    end

    # determine if brand is active.
    # deleted brands and brands with nil or future available_on date
    # are not active
    def active?
      active == true ? Spree.t(:active) : Spree.t(:disabled)
    end

    def has_range_categories?
      range_categories.present?
    end

    def range_image
      !image.file? && range.present? && range.images.any? ? range.images.first.attachment : image
    end

  end
end

require_dependency 'spree/product/scopes'