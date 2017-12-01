class HomeController < ApplicationController
  def index
    render("index.slang")
  end

  def register
    if (user = params["user"]) && !user.blank?
      session["user"] = user[0..100]
    end
    redirect_to(HomeController, :index)
  end

  def logout
    session.delete("user")
    redirect_to(HomeController, :index)
  end
end
