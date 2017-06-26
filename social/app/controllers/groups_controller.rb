class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
 
    if params.has_key?(:addGroup)
      current_user.groups<<(Group.find(params[:addGroup]))
      redirect_to "/groups/#{params[:addGroup]}"
    end
    if params.has_key?(:deleteGroup)
      current_user.groups.delete(Group.find(params[:deleteGroup]))
      redirect_to "/groups"
    end
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @posts = @group.posts.reverse
    @post = Post.new
    @group = Group.find(params[:id])
    @members = @group.users
    @advertisings = @group.advertisings
  end

  def members
    @group = Group.find(params[:id])
    @members = @group.users.select('users.*, usersingroups.permission as perm')
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.owner = current_user

    respond_to do |format|
      if @group.save
        current_user.groups<<@group
        sql = "UPDATE usersingroups SET permission = 'admin' WHERE user_id = '#{current_user.id}' AND group_id = '#{@group.id}';"
        ActiveRecord::Base.connection.execute(sql)
        format.html { redirect_to @group }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  #PATCH permission
  #PATCH /group/1/members
  def update_perm
    sql = "UPDATE usersingroups SET permission = '#{params[:newperm]}' WHERE user_id = '#{params[:userid]}' AND group_id = '#{params[:id]}';"
    ActiveRecord::Base.connection.execute(sql)
    redirect_to "/groups/#{params[:id]}/members"
  end

  def update_privacy
    group = Group.find(params[:id])
    group.privacy = params[:newprivacy]
    group.save
    redirect_to group
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :describe, :privacy, :image)
    end
end
