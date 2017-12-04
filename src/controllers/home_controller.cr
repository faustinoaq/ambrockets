class HomeController < ApplicationController
  USERS = [] of String

  def index
    render("index.slang")
  end

  def register
    user = params["user"]
    unless user.blank?
      user = user[0..100].strip
      if USERS.includes?(user)
        flash["danger"] = "#{user} is already used, please choose another name"
      else
        ChatSocket.broadcast("message", "chat_room:hello", "message_new", {
          "user"    => "",
          "message" => "#{user} joined to ambrockets!",
        })
        USERS << user
        session["user"] = user
      end
    end
    redirect_to(HomeController, :index)
  end

  def logout
    USERS.delete(session["user"])
    session.delete("user")
    redirect_to(HomeController, :index)
  end
end
