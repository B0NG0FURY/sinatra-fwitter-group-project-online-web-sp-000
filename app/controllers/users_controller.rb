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

    post '/user/new' do

    end

    get '/user/login' do
        erb :"/users/login"
    end

    helpers do

        def form_filled?
            !params[:user][:email].empty? && !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:password_verify].empty?
        end

        def password_verified?
            params[:user][:password] == params[:password_verify]
        end

    end

end
