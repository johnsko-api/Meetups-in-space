require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  erb :index
end

get '/create_meetup' do
  erb :create
end

post '/create_meetup' do
    title = params["title"]
    location = params["location"]
    description = params["description"]
    meetup = Meetup.new(title: title, location: location, description: description)
  if meetup.save
    flash[:notice] = "You have created a MeetUp in Space!! FLY AWAYY"
    redirect "/meetups/#{meetup[:id]}"
  else
    flash[:notice] = "Please provide non-empty information in required fields"
    redirect "/create_meetup"
  end
end


get '/meetups' do
  @meetup = Meetup.all
  #created an instance variable
  #to call all the meetups
  erb :meetup
end

get '/meetups/:id' do
  @id = Meetup.find_by_id(params[:id])
  erb :info
end



get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
