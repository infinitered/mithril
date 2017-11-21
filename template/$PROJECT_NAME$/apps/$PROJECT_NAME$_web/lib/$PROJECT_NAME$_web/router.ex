defmodule <%= @project_name_camel_case %>Web.Router do
  @moduledoc "The `Phoenix.Router` for `<%= @project_name_camel_case %>Web`"

  use <%= @project_name_camel_case %>Web, :router
  <%= if assigns[:accounts] && assigns[:html] do %>

  import <%= @project_name_camel_case%>Web.Session
  <% end %>
  <%= if assigns[:html] || assigns[:email] do %>

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    <%= if assigns[:accounts] && assigns[:html] do %>
    plug :load_token
    <% end %>
  end
  <% end %>
  <%= if assigns[:accounts] && assigns[:html] do %>

  pipeline :authorize do
    plug :require_token
  end
  <% end %>
  <%= if assigns[:api] do %>

  pipeline :api do
    plug :accepts, ["json"]
    <%= if assigns[:api] == "graphql" && assigns[:accounts] do %>
    plug <%= @project_name_camel_case %>API.Context
    <% end %>
  end
  <% end %>
  <%= if assigns[:api] == "graphql" do %>

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: <%= @project_name_camel_case %>API.Schema
    forward "/graphiql", Absinthe.Plug.GraphiQL, 
      schema: <%= @project_name_camel_case %>API.Schema<%= if assigns[:websockets] do %>,
      socket: <%= @project_name_camel_case %>Web.UserSocket
      <% end %>
  end
  <% end %>
  <%= if assigns[:html] do %>

  scope "/", <%= @project_name_camel_case %>Web do
    pipe_through :browser # Use the default browser stack

    <%= if assigns[:html] do %>
    get "/", PageController, :index
    <% end %>
  end
  <% end %>
  <%= if assigns[:accounts] && assigns[:html] do %>

  scope "/", <%= @project_name_camel_case %>Web.Accounts do
    pipe_through :browser

    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/forgot-password", ForgotPasswordController, :new
    post "/forgot-password", ForgotPasswordController, :create
    get "/reset-password", ResetPasswordController, :new
    post "/reset-password", ResetPasswordController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
  end

  scope "/", <%= @project_name_camel_case %>Web.Accounts do
    pipe_through [:browser, :authorize]

    get "/account", RegistrationController, :edit
    put "/account", RegistrationController, :update
  end
  <% end %>
  <%= if assigns[:email] do %>

  if Mix.env == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/dev/mailbox"]
    end
  end
  <% end %>
end
