class Indexer
  def initialize
    @index_hash = {}
  end

  def perform_indexing(hashArray, options)
    return @index_hash unless options.present?

    @index_hash = {}

    hashArray.each_with_index do |record, i|
      key = generate_key(record, options)

      @index_hash[ key.concat("@#{i}") ] = i
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
    options.map do |key_option, v| 
      record[key_option].to_s
    end
    .join(',')
  end
end 