class CartItem < ActiveRecord::Base
  # attr_accessible :movie_id, :cart_id, :price, :amount

  belongs_to :cart
  belongs_to :movie
end
