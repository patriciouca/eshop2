class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :movie

  def validate
    errors.add(:amount, "Debe ser uno o mas") unless amount.nil? || amount > 0
    errors.add(:price, "Debe ser positivo") unless price.nil? || price > 0.0
  end
end