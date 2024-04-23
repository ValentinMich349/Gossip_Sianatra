require 'gossip'
class ApplicationController < Sinatra::Base

# affiche index des elmts
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

# affiche elmt selon id
  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params['id'])}
  end

# affiche page création elmt
  get '/gossips/new/' do
    erb :new_gossip
  end

# envoi new elmt
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

# affiche page modif
  get '/gossips/:id/edit' do
    id = params['id']
    erb :edit , locals: {gossip: Gossip.find(id)}
  end

#  envoi modif elmt
  post '/gossips/:id/edit/' do
  Gossip.update(params["id"], params["updated_author"])
  redirect "/gossips/#{params['id']}"
  end
end
