class HomeController < ApplicationController
  private def message
    if user = session["user"]
      "{user} joined to ambrockets!"
    else
      "Someone is visiting ambrockets..."
    end
  end

  def index
    ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
      "user" => "Server",
      "message" => message
    })
    render("index.slang")
  end

  def register
    if (user = params["user"]) && !user.blank?
      session["user"] = user[0..100]
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
