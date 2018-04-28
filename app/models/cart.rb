class Cart < ActiveRecord::Base
  has_many :cart_items
  has_many :movies, :through => :cart_items

  def add(movie_id)
    items = cart_items.where(movie_id: movie_id)
    movie = Movie.find movie_id
    if items.size < 1
      ci = cart_items.create :movie_id => movie_id, :amount => 1, :price => movie.price
    else
      ci = items.first
      ci.update_attribute :amount, ci.amount + 1
    end
    ci
  end

  def remove(movie_id)
    ci = cart_items.where(movie_id: movie_id).first
    if ci.amount > 1
      ci.update_attribute :amount, ci.amount - 1
    else
      CartItem.destroy ci.id
    end
    ci
  end

  def total
    sum = 0
    cart_items.each do |item| sum += item.price * item.amount end
    sum
  end
end
