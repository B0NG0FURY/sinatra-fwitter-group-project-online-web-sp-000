class UsersController < ApplicationController

    get '/user' do
        @user = current_user
        if @user
            erb :"/users/index"
        end
    end

    get '/user/new' do
        erb :"/users/new"
    end

    get '/user/login' do
        erb :"/users/login"
    end

end
