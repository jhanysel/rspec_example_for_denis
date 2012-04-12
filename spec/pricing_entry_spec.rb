$LOAD_PATH.unshift("../lib")

require 'pricing_entry'

describe PricingEntry do
  context "without bulk information" do
    subject { PricingEntry.new "A", 12.00 }
    it "has the initial value for the product_code" do
      subject.product_code.should == "A"
    end
    it "has the initial value for the unit_price" do
      subject.unit_price.should == 12.00
    end
    it "has 0 for the volume_quantity" do
      subject.volume_quantity.should == 0
    end
    it "has 0 for the volume_price" do
      subject.volume_price.should == 0
    end
  end

  context "for an pricing entry with volume information" do
    subject { PricingEntry.new "B", 2.00, 3, 5.00 }
    it "has the initialized value for the volume_quantity" do
      subject.volume_quantity.should == 3
    end
    it "has the initialized value for the volume_price" do
      subject.volume_price.should == 5.00
    end
  end
end
