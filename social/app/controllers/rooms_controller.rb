class RoomsController < ApplicationController
before_filter :config_opentok,:except => [:index]
  def index
    @rooms = Room.where(:public => true).order("created_at DESC")
    @new_room = Room.new
  end

  def create
    session = @opentok.create_session

    @new_room = Room.new(room_params)
    @new_room.sessionId = session.session_id

    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/party/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms',
          :action => "index" }
      end
    end
  end

  def party
    @room = Room.find(params[:id])
    @tok_token = @opentok.generate_token @room.sessionId
  end

  private
    def config_opentok
      if @opentok.nil?
       	@opentok = OpenTok::OpenTok.new 45881452, "498bd80b038484311d1fe765eed3a6f1d1f301e6"
      end
    end

    def room_params
      params.require(:room).permit(:name, :public)
    end
end
