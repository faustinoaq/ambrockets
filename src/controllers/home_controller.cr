class HomeController < ApplicationController
  private property joined = false

  def index
    if (user = session["user"]) && !joined
      ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
        "user" => "Server",
        "message" => "#{user} joined to ambrockets!"
      })
    end
    render("index.slang")
  end

  def register
    if (user = params["user"]) && !user.blank?
      session["user"] = user[0..100]
      @joined = true
    end
    redirect_to(HomeController, :index)
  end

  def logout
    ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
      "user" => "Server",
      "message" => "#{session["user"]} left ambrockets..."
    })
    session.delete("user")
    @joined = false
    redirect_to(HomeController, :index)
  end
end
