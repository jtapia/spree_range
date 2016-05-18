module Spree
  module Admin
    class RangesController < ResourceController
      include Spree::Admin::BaseHelper
      rescue_from ActiveRecord::RecordNotFound, with: :render_404

      before_action :load_range, only: [:update, :edit, :destroy]

      def index
        respond_with(@collection)
      end

      def create
        @range = Spree::Range.new(range_params)
        set_include_ranges

        if @range.save
          flash.now[:success] = flash_message_for(@range, :successfully_created)
          render :edit
        else
          render :new
        end
      end

      def update
        @range.assign_attributes(range_params)
        set_include_ranges

        if @range.save
          flash[:success] = Spree.t('notice_messages.range_updated')
          redirect_to admin_ranges_path
        else
          flash[:error] = Spree.t('notice_messages.range_not_updated')
          render :edit
        end
      end

      def destroy
        if @range.destroy
          flash[:success] = Spree.t('notice_messages.range_deleted')
        else
          flash[:error] = Spree.t('notice_messages.range_not_deleted')
        end

        respond_with(@range) do |format|
          format.html { redirect_to admin_ranges_path }
          format.js  { render_js_for_destroy }
        end
      end

      private

      def range_params
        params.fetch(:range, {}).permit(*permitted_attributes)
      end

      def permitted_attributes
        [
          :name,
          :start_range,
          :end_range,
          :image,
          :include_range
        ]
      end

      def load_range
        @range = Spree::Range.find(params[:id])
      end

      def collection
        return @collection if @collection.present?
        # params[:q] can be blank upon pagination
        params[:q] ||= {}

        @search = Spree::Range.ransack(params[:q])
        @collection = @search.result.
              page(params[:page]).
              per(Spree::Config[:properties_per_page])
      end

      def set_include_ranges
        if range_params[:include_range]
          @range.include_range = range_params[:include_range].split(',')
        end
      end

    end
  end
end