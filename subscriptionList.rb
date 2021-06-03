require 'payjp'
require 'dotenv/load'
Payjp.api_key = ENV["PAYJP_SK_KEY"]

PAYJP_SUBSCRIPTION_LIMIT = 10

PLAN_IDS = [
  PLAN_A: "pln_02af5afedcdce4e1c64dfead3912",
  PLAN_B: "plan_500",
  PLAN_C: "pln_a7f7720837ffa78ac52924a6d667",
  PLAN_D: "hoge"
].freeze


@data = []
def get_subscription_data(offset = 0)
  subscriptions = Payjp::Subscription.all(
    plan: "pln_42a2eccdd41755ae234072711d0e",
    limit: PAYJP_SUBSCRIPTION_LIMIT,
    offset: offset
  )
  puts "#{offset}~#{offset + PAYJP_SUBSCRIPTION_LIMIT} done"
  @data += subscriptions.data
  get_subscription_data(offset + subscriptions.count) if subscriptions.has_more
end

offset = 0
get_subscription_data(offset)



@data.each_with_index do |subscription, index|
  customer = subscription.customer
  puts "#{index} #{customer}"
end
