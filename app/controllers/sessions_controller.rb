class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
     session[:user_id] = user.id
     redirect_to user, notice: "Successfully loged in."
    else
     render 'new', notice: "Something went wrong - try again"
    end
    #byebug
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end    
end