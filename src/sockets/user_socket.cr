struct UserSocket < Amber::WebSockets::ClientSocket
  channel "chat_room:*", ChatRoomChannel

  def on_connect
    if user = session["user"]
      !user.blank?
    end
  end
end
