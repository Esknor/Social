class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)

    if @message.save
    	User.find(params[:message][:sender]).send_messages<<@message
    	User.find(params[:message][:receiver]).received_messages<<@message
	    respond_to do |format|
	      format.html { redirect_to @message.receiver }
        end
    end
  end
private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content)
    end
end
