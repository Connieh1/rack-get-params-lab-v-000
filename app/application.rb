class Application

  @@items = []#["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

      if req.path.match(/items/)
          @@items.each do |item|
            resp.write "#{item}\n"
        end
      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
      # elsif req.path.match(/add/)
      #   item = req.params["q"]
      #   # resp.write "We don't have that item"
      #   resp.write handle_add(item)
      elsif req.path.match(/cart/)
        if @@cart.empty?
          resp.write "Your cart is empty"
        else  @@cart.each do |item|
          resp.write "#{item}\n"
          end
        end
      elsif req.path.match(/add/)
         product = req.params["q"]
      #   # resp.write "We don't have that item"
        # resp.write handle_add(item)
         if @@items.include?(product)
          # @@cart << product
          resp.write "added #{product}\n"
        # else
        #   resp.write "We don't have that item Will not add an item that is not in the @@items list"
        end
      else
        resp.write "Path Not Found"
    end

    resp.finish
  end


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  # def handle_add(item)
  #   if @@items.include?(item)
  #     @@cart << item
  #     return "added #{item}"
  #   # else
  #   #   return "We don't have that item Will not add an item that is not in the @@items list"
  #   end
  # end
end
