use Mix.Config

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"


<%= if assigns[:error_reporting] == "honeybadger" do %>
config :honeybadger,
  api_key: "DEV", #  # Needed so Honeybadger will compile, even though dev env is ignored
  environment_name: "dev"
<% end %>