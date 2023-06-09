class ApplicationController < Sinatra::Base

  get '/' do
    { message: "Hello world" }.to_json
  end
  get '/games' do
    # get all the games from the database
    games = Game.all
    # return a JSON response with an array of all the game data
    games.to_json
  end
  get '/games/:id' do
    # look up the game in the database using its ID
    game = Game.find(params[:id])
    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
