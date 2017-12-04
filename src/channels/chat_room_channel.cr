class ChatRoomChannel < Amber::WebSockets::Channel
  def handle_message(client_socket, message)
    rebroadcast!(message)
  end

  def handle_leave(client_socket)
    ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
      "user"    => "",
      "message" => "#{client_socket.session["user"]} left ambrockets...",
    })
  end
end
