$LOAD_PATH.unshift("../lib")

require 'terminal'

describe Terminal do
  let(:pricing_entries) {
    [
        PricingEntry.new("A", 2.00, 4, 7.00),
        PricingEntry.new("B", 12.00),
        PricingEntry.new("C", 1.25, 6, 6.00),
        PricingEntry.new("D", 0.15),
    ]
  }
  describe "when you scan an item with no pricing entry" do
    it "does something"
  end
  describe "calculating total price" do

    context "for a product code with only a unit price" do
      it "calculates the total price as quantity * unit price" do
        terminal = Terminal.new pricing_entries
        2.times do
          terminal.scan "B"
        end
        terminal.total.should == 24.00
      end
    end
    context 'for a product with a unit price and a quantity price' do
      it "calculates the total price using the quantity price first and then adds the unit price for extras" do
        terminal = Terminal.new pricing_entries
        5.times do
          terminal.scan 'A'
        end
        terminal.total.should == 9.00
      end
    end
    context "for the series of items ABCDABAA" do
      it "calculates the total amount properly" do
        terminal = Terminal.new pricing_entries
        %w{A B C D A B A A}.each do |product_code|
          terminal.scan(product_code)
        end
        terminal.total.should == 32.40
      end
    end

    context "for the series of items CCCCCCC" do
      it "calculates the total amount properly" do
        terminal = Terminal.new pricing_entries
        7.times do
          terminal.scan('C')
        end
        terminal.total.should == 7.25
      end
    end

    context "for the series of items ABCD" do
      it "calculates the total amount properly" do
        terminal = Terminal.new pricing_entries
        %w{A B C D}.each do |product_code|
          terminal.scan(product_code)
        end
        terminal.total.should == 15.40
      end
    end
  end
end
