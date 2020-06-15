class RushingsController < ApplicationController
  before_action :filter_and_sort

  def index
    @records = @rush.sort(
      offset: params[:offset].to_i-1, 
      limit:  params[:limit],
      field: params[:sort_field]
      )
    
    respond_to do |format|
      format.json{
        render json: {data: @records, total: @rush.total_records, page: params[:offset]}
      } 
    end
  end

  def download_csv
    records = @rush.sort(field: params[:sort_field])
    csv_string = @rush.generate_csv( records )
      
    respond_to do |format|
        format.csv {
            send_data csv_string, 
              :type => 'text/csv; charset=utf-8; header=present', 
              :disposition => "attachment; filename=rushing.csv", 
              :filename => "rushing.csv"
        }
    end
  end

  private

  def filter_and_sort
    @rush = Rush.new
    
    if params[:search].present?
      @rush.filter(field: "Player", search: params[:search])
    end
  end

end