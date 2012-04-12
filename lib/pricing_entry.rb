class PricingEntry
  attr_reader :product_code, :unit_price, :volume_quantity, :volume_price

  def initialize(product_code, unit_price, volume_quantity = 0, volume_price = 0)
    @product_code = product_code
    @unit_price = unit_price
    @volume_quantity = volume_quantity
    @volume_price = volume_price
  end
end
