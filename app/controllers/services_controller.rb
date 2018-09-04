class ServicesController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      Service,
      params[:filterrific],
      select_options: {
        sorted_by: Service.options_for_sorted_by, 
        with_country: Service.options_for_select
      },
      persistence_id: false
    ) or return
    @services = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
