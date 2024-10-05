require 'pry'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item_updater = item_updater(item)
      item_updater.update
    end
  end

  private 

  def item_updater(item)
    if item.name == "Aged Brie"
      AgedBrieUpdater.new(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      BackstagePassUpdater.new(item)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      SulfurasUpdater.new(item)
    else
      ItemUpdater.new(item)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class ItemUpdater
  def initialize(item)
    @item = item
  end

  def update
    update_sell_in
    update_quality
  end

  protected

  def update_sell_in
    @item.sell_in = @item.sell_in - 1
  end

  def update_quality
    @item.sell_in < 0 ? quality_degredation = 2 : quality_degredation = 1
    @item.quality -= quality_degredation
    @item.quality = 50 if @item.quality > 50
    @item.quality = 0 if @item.quality < 0
  end
end

class ConjuredUpdater < ItemUpdater
  def update_quality
    @item.quality -= 2
  end
end

class AgedBrieUpdater < ItemUpdater
  def update_quality
    @item.quality += 1
    @item.quality = 50 if @item.quality > 50
  end
end

class SulfurasUpdater < ItemUpdater
  def update_quality
  end
  def update_sell_in
  end
end

class BackstagePassUpdater < ItemUpdater
  def update_quality
    if @item.sell_in > 5 && @item.sell_in <= 10
      @item.quality += 2
    elsif @item.sell_in < 5 && @item.sell_in > 0
      @item.quality += 3
    elsif @item.sell_in <= 0
      @item.quality = 0
    else
      @item.quality += 1
    end
  end
end

