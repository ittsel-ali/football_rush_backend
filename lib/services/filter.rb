module Filter

  def by_string
    filter rows, key, value do |row|
        row[key] == value 
    end
  end

  def by_number(rows, key, value)
    return rows unless key and value

    filter rows, key, value do |row|
        row[key].to_f > value.to_f 
    end
  end

  private
  
  def filter(rows, key, value)
    rows.reject do |row|
      yield(row) if block_given? 
    end 
  end

  module_function :by_string
  module_function :by_number
  module_function :filter
end