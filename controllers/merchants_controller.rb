require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant')
also_reload('../models/*')

get '/merchants' do # INDEX
  @merchants = Merchant.all()
  erb( :'merchants/index' )
end

get '/merchants/new' do # NEW
  erb( :'merchants/new' )
end

# get '/merchants/:id' do
#   @merchant = Merchant.find(params[:id])
#   redirect to('/merchants/')
# end

post '/merchants' do # CREATE
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect to ('/merchants')
end

get '/merchants/:id/edit' do # EDIT
  @merchant = Merchant.find(params[:id].to_i)
  erb( :'merchants/edit')
end

post '/merchants/:id' do # UPDATE
  merchant_to_update = Merchant.new(params)
  merchant_to_update.update()
  redirect to '/merchants'
end