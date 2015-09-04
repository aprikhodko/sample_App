class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "You are successfully signed up!"
      flash[:color] = "valid"
    else
      flash[:notice] = "Gaah! Your forms is invalid"
      flash[:color] = "invalid"
    end
    render "new"
  end
end
