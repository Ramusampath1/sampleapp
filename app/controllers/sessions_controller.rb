class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    	#flash[:success] = "Welcome to the Sample App!"
    	#redirect_to @user
      # Log the user in and redirect to the user's show page.
    else
    	#flash[:danger] = 'Invalid email/password combination' # Not quite right!
      flash.now[:danger] = 'Invalid email/password combination'
      # Create an error message.
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
    redirect_to root_url
  end
end