class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?

        end
        erb :'/tweets/index'
    end
end
