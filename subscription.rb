require 'payjp'
require 'dotenv/load'
Payjp.api_key = ENV["PAYJP_SK_KEY"]

plan = Payjp::Plan.create(
  amount: 500,
  currency: 'jpy',
  interval: 'month',
  trial_days: 30
)

20.times do
  customer = Payjp::Customer.create(
    description: 'test'
  )

  Payjp::Subscription.create(
    plan: plan.id,
    customer: customer.id
  )
end
