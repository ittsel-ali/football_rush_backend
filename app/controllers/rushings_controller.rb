class RushingsController < ApplicationController

  def index
    rush = Rush.new
    if params[:search]
      rush.records = rush.filter(field: "Player", search: params[:search])
    end
    
    @records = rush.sort(
      offset: params[:offset].to_i-1, 
      limit:  params[:limit],
      field: params[:sort_field]
      )

    respond_to do |format|
      format.json{
        render json: {data: @records, total: rush.total_records, page: params[:offset]}
      } 
    end
  end

end