class UsersController < ApplicationController

    get '/user' do
        @user = current_user
        if @user
            erb :"/users/index"
        else
            erb :error
        end
    end

    post '/user' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/user'
        else
            flash[:error] = "The username or password is incorrect."
            redirect '/user/login'
        end
    end

    get '/user/new' do
        erb :"/users/new"
    end

    post '/user/new' do
        if form_filled? && password_verified? && !user_exists?(params[:user][:username])
            user = User.create(params[:user])
            session[:user_id] = user.id
            redirect '/user'
        elsif form_filled? && !password_verified && !user_exists?(params[:user][:username])
            flash[:error] = "Passwords entered do not match. Please try again."
            redirect '/user/new'
        elsif form_filled? && user_exists?(params[:user][:username])
            flash[:error] = "That username already exists. Try again."
            redirect '/user/new'
        elsif !form_filled?
            flash[:error] = "One or more forms not completed. Please completely fill out all forms to create account."
            redirect '/user/new'
        end
    end

    get '/user/login' do
        erb :"/users/login"
    end

    get '/user/logout' do
        session.clear
        redirect '/user/login'
    end

    helpers do

        def form_filled?
            !params[:user][:email].empty? && !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:password_verify].empty?
        end

        def password_verified?
            params[:user][:password] == params[:password_verify]
        end

        def user_exists?(name)
            User.find_by(username: name)
        end

    end

end
