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

  subject { Terminal.new pricing_entries }
  describe "when you scan an item with no pricing entry" do
    it "does something"
  end
  describe "calculating total price" do

    context "for a product code with only a unit price" do
      it "calculates the total price as quantity * unit price" do
        2.times do
          subject.scan "B"
        end
        subject.total.should == 24.00
      end
    end
    context 'for a product with a unit price and a quantity price' do
      it "calculates the total price using the quantity price first and then adds the unit price for extras" do
        5.times do
          subject.scan 'A'
        end
        subject.total.should == 9.00
      end
    end
    context "for the series of items ABCDABAA" do
      it "calculates the total amount properly" do
        %w{A B C D A B A A}.each do |product_code|
          subject.scan(product_code)
        end
        subject.total.should == 32.40
      end
    end

    context "for the series of items CCCCCCC" do
      it "calculates the total amount properly" do
        7.times do
          subject.scan('C')
        end
        subject.total.should == 7.25
      end
    end

    context "for the series of items ABCD" do
      it "calculates the total amount properly" do
        %w{A B C D}.each do |product_code|
          subject.scan(product_code)
        end
        subject.total.should == 15.40
      end
    end
  end
end
