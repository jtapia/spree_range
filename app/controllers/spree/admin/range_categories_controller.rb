module Spree
  module Admin
    class RangeCategoriesController < ResourceController
      include Spree::Admin::BaseHelper

      before_action :load_range
      before_action :load_range_category, only: [:edit, :destroy]

      def create
        @range_category = @range.range_categories.new(range_category_params)
        if @range_category.save
          flash.now[:success] = flash_message_for(@range_category, :successfully_created)
          render :edit
        else
          render :new
        end
      end

      def destroy
        if @range_category.destroy
          flash[:success] = Spree.t('notice_messages.range_category_deleted')
        else
          flash[:error] = Spree.t('notice_messages.range_category_not_deleted')
        end

        respond_with(@range_category) do |format|
          format.html { redirect_to admin_range_categories_path }
          format.js  { render_js_for_destroy }
        end
      end

      private

      def range_category_params
        params.fetch(:range_category, {}).permit(*permitted_attributes)
      end

      def permitted_attributes
        [
          :name,
          :description,
          :image
        ]
      end

      def load_range
        @range = Spree::Range.find(params[:range_id])
      end

      def load_range_category
        @range_category = Spree::RangeCategory.find(params[:id])
      end

    end
  end
end