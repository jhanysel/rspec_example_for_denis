class Terminal
  # Public: Create a new terminal instance
  #
  # pricing_entries  - An array of pricing entries
  #
  def initialize(pricing_entries)
    @pricing_entries = pricing_entries
    @items = []
  end

  # Public: Scan a product into the terminal
  #
  # product_code  - A string that represents the product
  #
  def scan(product_code)
    @items << product_code
  end

  # Public: The total of the scanned in items
  #
  # Returns a floating point number.
  def total
    @pricing_entries.inject(0) do |total_price, pricing_entry|
      number_of_items = @items.count(pricing_entry.product_code)

      number_of_volume_groups, number_of_singles = divide_items(number_of_items, pricing_entry.volume_quantity)
      total_price + (number_of_volume_groups * pricing_entry.volume_price) + (pricing_entry.unit_price * number_of_singles)
    end
  end

  private
  def divide_items(number_of_items, volume_quantity)
    if volume_quantity == 0
      [0, number_of_items]
    else
      [number_of_items / volume_quantity, number_of_items % volume_quantity]
    end
  end
end
