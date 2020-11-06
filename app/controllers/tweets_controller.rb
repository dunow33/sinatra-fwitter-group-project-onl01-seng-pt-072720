class TweetsController < ApplicationController
    get '/tweets' do
        if Helpers.logged_in?
            erb :'tweets/tweets'
        else 
            redirect to '/login'
        end 
    end

    get '/tweets/new' do
        if Helpers.logged_in?
            erb :'tweets/new'
        else 
            redirect to '/login'
        end 
    end 

    post '/tweets' do 
        if params[:content] == ""
            redirect to '/tweets/new'
          else  
            tweet = Tweet.create(content: params[:content])
            Helpers.current_user.tweets << tweet
            redirect to "/tweets/#{tweet.id}"
        end 
    end 

    get '/tweets/:id' do 
        if Helpers.logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to '/login'
        end 
    end 

    get '/tweets/:id/edit' do 
        if Helpers.logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == Helpers.current_user
                erb :'tweets/edit_tweet'
            else  
                redirect to '/tweets'
            end 
        else 
            redirect to '/login'
        end 
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])

        if params[:content] == ""
            redirect to "/tweets/#{@tweet.id}/edit"
        else  
            @tweet.update(content: params[:content])
            
            redirect to "/tweets/#{@tweet.id}"
        end 
    end 

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])

        if @tweet && @tweet.user == Helpers.current_user
            @tweet.delete 

            redirect to '/tweets'
        else 
            redirect to '/login'
        end 
    end 
end
