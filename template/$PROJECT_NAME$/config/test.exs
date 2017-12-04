use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

<%= if assigns[:error_reporting] == "honeybadger" do %>
config :honeybadger,
  api_key: "TEST", # Needed so Honeybadger will compile, even though test env is ignored
  environment_name: "test"
<% end %>