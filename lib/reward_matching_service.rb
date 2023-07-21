require 'csv'
require './lib/purchase_event_queue'

class RewardMatchingService

  def initialize
    @queue = PurchaseEventQueue.new
  end

  def create_reward_matched_event
    event = @queue.get_next_purchase_event

    purchase_event_id = event[:purchase_event_id]
    saver_id = event[:saver_id]
    product_code_id = event[:product_code_id]
    quantity = event[:quantity]

    #If there was no test, we could run this and p / puts to the terminal
    # puts "purchase event id: " + purchase_event_id.to_s
    # puts "saver id: " + saver_id.to_s
    # puts "product code id: " + product_code_id.to_s
    # p "quantity: " + quantity.to_s
    
    all_product_reward_cents = Hash.new
    CSV.foreach("./data/rewards.csv") do |row_info| 
      all_product_reward_cents[row_info[0].to_i] = row_info[1].to_i 
    end

    # p all_product_reward_cents

    cents_reward = all_product_reward_cents[product_code_id]

    award_amount_cents = cents_reward * quantity

    # Grab the next purchase event off the queue
    # Find the product code id from the purchase event
    # Look up the reward amount in cents in rewards.csv
    # Find the quantity from the purchase event
    # Multiply quantity and reward amount to get the total award amount in cents
    # Get the saver_id and purchase_event_id from purchase event
    # Output a reward matched event
    return {
      purchase_event_id: purchase_event_id,
      saver_id: saver_id,
      award_amount_cents: award_amount_cents,
    }
  end
end

# If there was no test, we could run this and p / puts to the terminal:
# RewardMatchingService.new.create_reward_matched_event

# Next steps would be to refactor this method into helper methods.