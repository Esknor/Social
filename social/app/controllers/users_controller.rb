class UsersController < ApplicationController


  def index
    @options = [ 'none', 'manager', 'super' ]
    @users = User.all
  end

  def update
    us = User.find(params[:id])
    redirect_to controller: "users", action: "index"
  end

  def show
    @user = User.find(params[:id])
    @userinfo = @user.userinfo
    @message = Message.new
    @messages = []
    if get_perm != "visitor"
      @messages = Message.where("(sender = ? AND receiver = ?) OR (sender = ? AND receiver = ?)", 
                                current_user.id, @user.id,
                                @user.id, current_user.id).reverse
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      userinfo = Userinfo.create
      @user.userinfo = userinfo
      @user.userinfo_id = userinfo.id
      @user.save
      
      redirect_to root_url
    else
      render 'new'
    end
  end
   def destroy 
    @user = User.find(params[:id])
    @user.destroy 
    respond_to do |format|
      format.html { redirect_to userinfos_url }
      format.json { head :no_content }
    end
  end
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

end
