class Public::MessagesController < ApplicationController
before_action :authenticate_user!
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    if @message.save

      # 新規作成された@messageに紐づくroomを@roomに格納する
      @room = @message.room
      # 本引数を２つ持たせてcreate_notification_dmメソッドを実行
      @room.create_notification_dm(current_user, @message.id)

      redirect_to room_path(@message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def message_params
      params.require(:message).permit(:room_id, :body)
    end

end
