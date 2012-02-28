# encoding: UTF-8
module Mongo
  class Cursor
    def page(page)
      skip([(page.to_i-1)*10,0].max).limit(10)
    end
  end
end

