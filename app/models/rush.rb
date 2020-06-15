require 'csv'

class Rush
  attr_accessor :records
  
  def initialize(*args)
    @records = args.slice!(0) || load_json
  end

  def filter(*args)
    args = args.slice!(0) || {}
    
    key = args[:field]
    val = args[:search]

    self.records = Filter.by_string(self.records, key, val)
  end

  def sort(*args)
    args = args.slice!(0) || {}
    
    fild = args[:field]  || nil
    data = args[:records] || records

    offset = (args[:offset] || 0).to_i
    limit  = (args[:limit]  || data.count).to_i

    indexer = Indexer.new
    indexer.perform_indexing( data, fild )

    sorted_index = MergeSort.sort(indexer.get_index_hash.keys)
    sorted_index = sorted_index[offset*limit, limit]
    
    if sorted_index.blank?
      return data[offset*limit, limit]
    end
  
    sorted_index.map do |id|
      data[ indexer.find(id) ]
    end
  end

  def total_records
    records.count
  end

  def generate_csv(records)
    return nil unless records.present?
    
    csv_string = CSV.generate do |csv|
      csv << records[0]&.keys
      
      records.each do |record|
        csv << record.values
      end
    end
  end

  private 
  
  def load_json
    ActiveSupport::JSON.decode( File.read('app/models/rushing.json') )
  end

  
end