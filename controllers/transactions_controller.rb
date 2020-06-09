require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction')
also_reload('../models/*')

get '/transactions' do
  @transactions = Transaction.all()
  @total = Transaction.total()
  erb( :'transactions/index' )
end

get '/transactions/sort-by-date' do
  @sorted_transactions = Transaction.sort_by_date()
  @total = Transaction.total() 
  erb( :'transactions/sort_by_date')
end

get '/transactions/new' do
  @tags = Tag.all
  @merchants = Merchant.all
  erb( :'transactions/new' )
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to ('/transactions')
end