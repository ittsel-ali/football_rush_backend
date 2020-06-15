class Indexer
  def initialize
    @index_hash = {}
  end

  def perform_indexing(hashArray, options)
    return @index_hash unless options.present?

    @index_hash = {}

    hashArray.each_with_index do |record, i|
      key = generate_key(record, options)

      @index_hash[ key ] = i
    end

    @index_hash
  end

  def find(key)
    @index_hash[key]
  end

  def get_index_hash
    @index_hash
  end

  
  private 
  
  def generate_key(record, options)
    record[options].to_s.gsub(/[^0-9\.\-]/,'').to_f
  end
end 