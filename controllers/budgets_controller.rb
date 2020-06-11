require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/budget')
also_reload('../models/*')

get '/budgets' do #INDEX
  @budgets = Budget.all()
  @total = Transaction.total()
  erb( :'budgets/index')
end

get '/budgets/:id/edit' do # EDIT
  @budget = Budget.find(params[:id].to_i)
  erb( :'budgets/edit')
end

post '/budgets/:id' do # UPDATE
  budget_to_update = Budget.new(params)
  budget_to_update.update()
  redirect to '/budgets'
end


