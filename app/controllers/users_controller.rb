class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "fwitter_password"
    end

    get '/signup' do
        if !logged_in?
          erb :'/users/signup'
        else
          redirect '/tweets'
        end
    end
end
