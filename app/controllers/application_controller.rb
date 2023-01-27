class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # fetch for all bars on "home page"
  get '/bars' do
    bars = Bar.all
    bars.to_json(only: [:id, :name, :category, :price, :image, :favorited])
  end

#  get for each individual bar in bar info
  get '/bars/:id' do
    bar = Bar.find(params[:id])
    bar.to_json(only: [:name, :location ,:category, :price, :closing_time], include: {reviews: {only: [:star_rating, :content]}})
  end

  get '/reviews' do
    reviews = Review.all
    reviews.to_json(include: {user: {only: [:username]}})
  end
  
  # get to see a specific review
  get '/reviews/:id' do
    review = Review.find(params[:id])
    review.to_json(only: [:star_rating, :content], include: {user: {only: [:username]}})
  end
  
  # post to create a review
  post '/reviews' do
    review = Review.create(star_rating:params[:star_rating], content:params[:content], bar_id:params[:bar_id], user_id:params[:user_id])
    review.to_json
  end

  # patch to edit a review
  patch '/reviews/:id' do
    review = Review.find(params[:id])
    review.update(
      content: params[:content],
      star_rating: params[:star_rating]
    )
    review.to_json(include: {user: {only: [:username]}})
  end
  
  # delete to delete a review
  delete '/reviews/:id' do
    review = Review.find(params[:id])
    review.destroy
    review.to_json
  end

  # get to see all bar crawls
  get '/crawl_list' do
    bar_crawl = BarCrawl.all
    bar_crawl.to_json
  end

  get '/crawl_list/:id' do
    bar_crawl = BarCrawl.find(params[:id])
    bar_crawl.to_json(only: [:bar_crawl_name], include: {user: {only: [:display_name]}})
  end

  post '/crawl_list' do 
    bar_crawl_bar = BarCrawlBar.create(bar_id:params[:bar_id], bar_crawl_id:params[:bar_crawl_id])
    bar_crawl_bar.to_json
  end

get '/users' do 
    user = User.all
    user.to_json
  end

  get '/users/:id' do 
    user = User.find(params[:id])
    user.to_json(only: [:username], include: {reviews: {only: [:star_rating, :content]}})
  end

  # patch for favoriting a bar
  patch '/bars/:id' do
    Bar.find(params[:id]).update(favorited: params[:favorited]).to_json
  end

end
