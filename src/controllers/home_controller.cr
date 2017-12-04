class HomeController < ApplicationController
  def index
    ChatSocket.broadcast("message", "chat_room:hello", "message_new", {"message" => "Someone is visiting ambrockets..."})
    render("index.slang")
  end

  def register
    if (user = params["user"]) && !user.blank?
      session["user"] = user[0..100]
      ChatSocket.broadcast("message", "chat_room:hello", "message_new", {"message" => "#{session["user"]} joined to ambrockets!"})
    end
    redirect_to(HomeController, :index)
  end

  def logout
    session.delete("user")
    redirect_to(HomeController, :index)
  end
end
