module Helpers
    def includesKey?(arr, code) 
        arr.any? do |item|
            item["code"] == code
        end
    end
end