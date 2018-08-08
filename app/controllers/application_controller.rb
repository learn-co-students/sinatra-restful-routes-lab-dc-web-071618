class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find(id)

    erb :show
  end

  get '/recipes/:id/edit' do
    id = params[:id]
    @recipe = Recipe.find(id)

    erb :edit
  end

  post '/recipes' do
    recipe = Recipe.create(params)

    redirect "/recipes/#{recipe.id}"
  end

  patch '/recipes/:id' do
    id = params[:id]
    @recipe = Recipe.find(id)

    name = params[:name]
    ingredients = params[:ingredients]
    cook_time = params[:cook_time]

    @recipe.update(name: name, ingredients: ingredients, cook_time: cook_time)

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    id = params[:id]
    recipe = Recipe.find(id)
    recipe.destroy
    redirect '/recipes'
  end
end
