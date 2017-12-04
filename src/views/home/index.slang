div#logo.col-sm-6
div.col-sm-6
  h2 Welcome to Ambrockets!
  p A simple WebSockets example using
    a href="https://amberframework.org/" Amber Framework
    😎🚀
  - if user = session["user"]
    p You are
      span.user
        = user
      a.btn.btn-danger.btn-xs href="/logout"
        | Logout
    div#messages
    == form(class: "form-group", id: "form-message") do
      == text_field(name: "message", autofocus: "", required: "", class: "form-control", id: "message", placeholder: "Your message here")
    - :end
  - else
    == form(action: "/register", class: "form-group") do
      == csrf_tag
      == text_field(name: "user", autofocus: "", required: "", class: "form-control", placeholder: "Your name here")
    - :end
  - :end
