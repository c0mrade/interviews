require 'rspec'
require_relative 'gilded_rose.rb'
# Assuming the Item and GildedRose classes are loaded

describe GildedRose do
  let(:items) { [] }
  let(:gilded_rose) { GildedRose.new(items) }

  context "with normal items" do
    it "decreases sell_in and quality by 1" do
      items << Item.new("Normal Item", 10, 20)
      gilded_rose.update_quality()
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 19
    end

    it "quality does not go below 0" do
      items << Item.new("Normal Item", 5, 0)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  context "with Aged Brie" do
    it "increases quality as it ages" do
      items << Item.new("Aged Brie", 5, 10)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 11
    end

    it "does not increase quality beyond 50" do
      items << Item.new("Aged Brie", 5, 50)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 50
    end
  end

  context "with Backstage passes" do
    it "increases quality by 1 when more than 10 days left" do
      items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 21
    end

    it "increases quality by 2 when 10 days or less left" do
      items << Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 22
    end

    it "increases quality by 3 when 5 days or less left" do
      items << Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 23
    end

    it "drops quality to 0 after the concert" do
      items << Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  context "with Sulfuras" do
    it "does not decrease in quality or sell_in" do
      items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
      gilded_rose.update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 80
    end
  end

  context "with expired items" do
    it "decreases quality twice as fast after expiration" do
      items << Item.new("Normal Item", 0, 10)
      gilded_rose.update_quality()
      expect(items[0].quality).to eq 8
    end
  end
end

