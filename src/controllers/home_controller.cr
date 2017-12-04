class HomeController < ApplicationController
  def index
    render("index.slang")
  end

  def register
    if (user = params["user"]) && !user.blank?
      session["user"] = user[0..100]
      ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
        "user" => "Server",
        "message" => "#{session["user"]} joined to ambrockets!"
      })
    end
    redirect_to(HomeController, :index)
  end

  def logout
    ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
      "user" => "Server",
      "message" => "#{session["user"]} left ambrockets..."
    })
    session.delete("user")
    redirect_to(HomeController, :index)
  end
end
