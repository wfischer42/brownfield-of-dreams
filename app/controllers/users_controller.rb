class UsersController < ApplicationController

  def show
    unless current_user
      render "sessions/new"
      return
    end
    if current_user.active?
      @facade = UserDashboardFacade.new(current_user)
      render "users/active/show"
    else
      render "users/inactive/show"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      UserMailer.welcome_email(current_user, request.base_url).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end
end
