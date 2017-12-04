class HomeController < ApplicationController
  USERS = [] of String

  def index
    render("index.slang")
  end

  def register
    if (user = params["user"]) && !user.blank?
      user = user[0..100]
      if USERS.includes?(user)
        flash["warning"] = "#{user} is alreade in use, please choose another name"
      else
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
