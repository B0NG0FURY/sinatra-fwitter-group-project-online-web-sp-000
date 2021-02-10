class TweetsController < ApplicationController

    get '/tweets' do
        @user = current_user
        if @user
            @tweets = Tweet.all
            erb :"/tweets/index"
        else
            erb :error
        end
    end

    post '/tweets' do
        user = current_user
        if !params[:content].empty?
            tweet = Tweet.create(content: params[:content])
            tweet.user = user
            tweet.save
            redirect "/tweets/#{tweet.id}"
        else
            flash[:error] = "Cannot create blank tweet. Please try again."
            redirect '/tweets/new'
        end
    end

    get '/tweets/new' do
        @user = current_user
        if @user
            erb :"/tweets/new"
        else
            erb :"/tweets/error"
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @user = current_user
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/show"
        else
            erb :error
        end
    end

    get '/tweets/:id/edit' do
        @user = current_user
        if @user
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/edit"
        end
    end

end
