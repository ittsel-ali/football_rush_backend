module MergeSort
  
  def sort(list)
    return list if list.size <= 1
    
    mid = list.size / 2
    
    left  = list [0,mid]
    right = list [mid, list.size]
    
    merge(sort(left),sort(right))
  end

  private
  
  def merge(left, right, scheme=:to_f)
    sorted = []
    
    until left.empty? || right.empty?
      if left.first.send(scheme) < right.first.send(scheme)
        sorted << left.shift
      else
        sorted << right.shift
      end
    end
    
    sorted.concat(left).concat(right)
  end

  module_function :sort
  module_function :merge
end
