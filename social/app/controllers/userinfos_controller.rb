class UserinfosController < ApplicationController
  before_action :set_userinfo, only: [:edit, :update, :destroy]

  # GET /userinfos
  # GET /userinfos.json
  def index
    if params.has_key?(:addFriend)
      current_user.users<<(User.find(params[:addFriend]))
    end
    if params.has_key?(:deleteFriend)
      current_user.users.delete(User.find(params[:deleteFriend]))
    end
    @friends = []
    if !current_user.nil?
      @friends = current_user.users
    end
    @userinfos = Userinfo.all
  end


  # GET /userinfos/new
  def new
    @userinfo = Userinfo.new
  end

  # GET /userinfos/1/edit
  def edit
  end

  # POST /userinfos
  # POST /userinfos.json
  def create
    @userinfo = Userinfo.new(userinfo_params)

    respond_to do |format|
      if @userinfo.save
        format.html { redirect_to @userinfo }
        format.json { render :show, status: :created, location: @userinfo }
      else
        format.html { render :new }
        format.json { render json: @userinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userinfos/1
  # PATCH/PUT /userinfos/1.json
  def update
    respond_to do |format|
      if @userinfo.update(userinfo_params)
        format.html { redirect_to current_user }
        format.json { render :show, status: :ok, location: @userinfo }
      else
        format.html { render :edit }
        format.json { render json: @userinfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userinfos/1
  # DELETE /userinfos/1.json
  def destroy
    @userinfo.destroy
    respond_to do |format|
      format.html { redirect_to userinfos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userinfo
      @userinfo = Userinfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userinfo_params
      params.require(:userinfo).permit(:firstname, :lastname, :status, :permission, :avatar)
    end
end
