module Rush
  
  def filter(*args)
    args = args.slice!(0) || {}
    
    opts = args[:options] || {}
    data = args[:records] || load_json

    data.reject do |rush|

    end
  end

  def sort(*args)
    args = args.slice!(0) || {}
    
    opts = args[:options] || {}
    data = args[:records] || load_json

    data = Filter.by_number(data, opts.keys.first, opts[opts.keys.first])

    offset = args[:offset]
    limit  = args[:limit]

    indexer = Indexer.new
    indexer.perform_indexing( data, opts )

    sorted_index = MergeSort.sort( indexer.get_index_hash.keys )
    
    if offset and limit
      sorted_index = sorted_index[offset*limit, limit]
    end

    sorted_index.map do |link|
      data[ indexer.find(link) ]
    end
  end
  

  private 
  
  def load_json
    ActiveSupport::JSON.decode( File.read('app/models/rushing.json') )
  end

  module_function :load_json
  module_function :sort
  module_function :filter
end