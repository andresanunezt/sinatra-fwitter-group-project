#signup is like new.erb
class UsersController < ApplicationController
    


  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        else
        erb :'users/signup'
        end
      end
    
      post '/signup' do
        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if user.save && user.username != "" && user.email != ""
            session[:user_id] = user.id
            redirect to "/tweets"
          else
            redirect '/signup'
          end
          redirect to "/tweets"
        end

        get '/login' do
          if logged_in?
            redirect '/tweets'
          else
          erb :'users/login'
          end
        end


        post '/login' do
          user = User.find_by(:username => params[:username])
          if user && user.authenticate(params[:password])
            session[:user_id] = user.id
              redirect "/tweets"
            else
              redirect "/login"
            end
          end
          
            
        
          get '/logout' do
            if logged_in?
              session.destroy
              redirect '/login'
            else
              redirect '/'
            end
          end

    
end
