require 'json'

class PurchaseEventQueue
  attr_reader :events
  
  def initialize
    # Dont have to make keys symbols, but it sure looks nice: 
    @events = JSON.parse(File.read('./data/purchase_events.json'), symbolize_names: true)
  end

  def get_next_purchase_event
    @events.shift
  end
end