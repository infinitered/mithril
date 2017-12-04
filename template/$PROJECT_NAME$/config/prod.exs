use Mix.Config

# Do not print debug messages in production
config :logger, level: :info


<%= if assigns[:error_reporting] == "honeybadger" do %>
config :honeybadger,
  api_key: System.get_env("HONEYBADGER_API_KEY"),
  environment_name: System.get_env("HONEYBADGER_ENV") || "prod",
<% end %>