class TweetsController < ApplicationController

    get '/tweets' do
        @user = current_user
        if @user
            @tweets = Tweet.all
            erb :"/tweets/index"
        end
    end

    get '/tweets/new' do
        @user = current_user
        if @user
            erb :"/tweets/new"
        end
    end

    get '/tweets/:id' do
        @user = current_user
        if @user
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/show"
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
