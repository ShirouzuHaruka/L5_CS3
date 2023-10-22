require 'bcrypt'

class TopController < ApplicationController
  def main
    if session[:login_uid] != nil
      render "main"
    else
      render "login"
    end
  end

  def login
    if User.find_by(uid: params[:uid])
      user = User.find_by(uid: params[:uid])
      login_password =  BCrypt::Password.new(user.pass)
      if login_password == params[:pass]
        session[:login_uid] = user.id
        redirect_to top_main_path
      else
        render "error"
      end
    else
      render "error"
    end
  end
  
  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
  
  def new
    render "new"
  end
  
  def register
    signup_password = BCrypt::Password.create(params[:pass])
    User.create(uid: params[:uid], pass: signup_password)
    render 'register'
  end
end
