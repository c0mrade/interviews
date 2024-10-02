require_relative 'max_price.rb'

RSpec.describe MaxPrice do
  describe ".call" do
    context "when prices are provided in an increasing order" do
      it "returns the maximum profit possible" do
        prices = [7, 1, 5, 3, 6, 4]
        expect(MaxPrice.call(prices)).to eq(5)
      end
    end

    context "when prices are provided in a decreasing order" do
      it "returns zero as no profit is possible" do
        prices = [7, 6, 4, 3, 1]
        expect(MaxPrice.call(prices)).to eq(0)
      end
    end

    context "when all prices are the same" do
      it "returns zero as no profit is possible" do
        prices = [5, 5, 5, 5, 5]
        expect(MaxPrice.call(prices)).to eq(0)
      end
    end

    context "when only one price is given" do
      it "returns zero as no transactions are possible" do
        prices = [10]
        expect(MaxPrice.call(prices)).to eq(0)
      end
    end

    context "when the input is an empty array" do
      it "returns zero as there are no prices" do
        prices = []
        expect(MaxPrice.call(prices)).to eq(0)
      end
    end

    context "when prices fluctuate and the last price is the highest" do
      it "calculates the correct maximum profit" do
        prices = [3, 8, 2, 5, 9]
        expect(MaxPrice.call(prices)).to eq(7)  # Buy at 2, sell at 9
      end
    end
  end
end
