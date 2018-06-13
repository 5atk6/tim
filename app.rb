require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'
require 'securerandom'
require 'pony'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

get '/' do
  @categories = Category.all
  @organizations = Organization.all
  @events = Event.all
  erb :index;
end

get '/signup' do
  erb :sign_up
end

post '/signup' do
  random_password = SecureRandom.base64(8)
  user = User.create(
    mail: params[:mail],
    password: random_password
    )
  if user.persisted?
    session[:user] = user.id
  end
  
  Pony.mail({
    :to => params[:mail], 
    :subject => "TIM password",
    :body => random_password,
    :via => :smtp,
    :via_options => {
      :address              => 'smtp.gmail.com',
      :port                 => '587',
      :enable_starttls_auto => true,
      :user_name            => 'tsukuba.international.matome', #@gmail.com',
      :password             => `cat .password`,
      :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
      :domain               => "gmail.com" # the HELO domain provided by the client to the server
    }
  })
  
  redirect '/'
end

get '/signin' do
  erb :sign_in
end

post '/signin' do
  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/organization/add' do
  if current_user.nil?
    erb :please_login
  else
    @categories = Category.all
    erb :organization_add
  end
end

post '/organization/add' do
  Organization.create({
    name: params[:name],
    body: params[:body],
    category_id: params[:category]
  })
  
  redirect '/'
end

get '/event/add' do
  if current_user.nil?
    erb :please_login
  else
    erb :event_add
  end
end

post '/event/add' do
  Event.create({
    title: params[:title],
    content: params[:content],
    venue: params[:venue],
    start_time: Date.parse(params[:start_time]),
    active_time: params[:active_time]
  })
  
  redirect '/'
end

get '/category/:id' do
  @categories    = Category.all
  @category      = Category.find(params[:id])
  @category_name = @category.name
  @organizations = @category.organizations
  @events        = Event.all
  erb :index
end