defmodule <%= @project_name_camel_case %>API.Application do
  @moduledoc """
  The `<%= @project_name_camel_case %>API` OTP Application definition. This is where the
  supervision tree for `<%= @project_name_camel_case %>API` is defined.
  """

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      <%= if assigns[:websockets] do %>
      supervisor(Absinthe.Subscription, [<%= @project_name_camel_case %>Web.Endpoint]),
      worker(<%= @project_name_camel_case %>API.PubSub.Repeater, [<%= @project_name_camel_case %>Web.Endpoint])
      <% else %>
      # worker(module, args)
      <% end %>
    ], strategy: :one_for_one, name: <%= @project_name_camel_case %>API.Supervisor)
  end
end