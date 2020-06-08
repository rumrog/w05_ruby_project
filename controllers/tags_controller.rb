require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
also_reload('../models/*')

get '/tags' do
  @tags = Tag.all()
  erb( :'tags/index' )
end

get '/tags/new' do
  erb( :'tags/new' )
end

post '/tags' do
  @tag = Tag.new(params)
  @tag.save()
  redirect to ('/tags')
end

get '/tags/:id/edit' do # EDIT
  @tag = Tag.find(params[:id].to_i)
  erb( :'tags/edit')
end

post '/tags/:id' do # UPDATE
  tag_to_update = Tag.new(params)
  tag_to_update.update()
  redirect to '/tags'
end