module Crjsc
  class Retainer
    @@classes = Array(Void*).new

    def self.remove(v : Void*)
      idx = 0
      @@classes.each do |i|
        if i == v
          @@classes.pop(i)
          return v
        end
        idx += 1
      end
    end
  end
end
