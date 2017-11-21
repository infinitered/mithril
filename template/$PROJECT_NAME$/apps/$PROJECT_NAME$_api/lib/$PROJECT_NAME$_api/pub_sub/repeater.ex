<% MixTemplates.ignore_file_and_directory_unless(assigns[:websockets] != nil) %>
defmodule <%= @project_name_camel_case %>API.PubSub.Repeater do
  @moduledoc """
  Listens to `<%= @project_name_camel_case %>.PubSub`'s realtime interface and converts events 
  on certain topics to Absinthe subscription events using 
  `Absinthe.Subscription.publish/3`.

  This allows `<%= @project_name_camel_case %>` to publish regular Elixir tuple events 
  about realtime events which are occuring in the business logic. `<%= @project_name_camel_case %>API`
  can pick up on those events and broadcast them the way GraphQL expects.

  The flow works like this:

  1. Client submits a mutation to `<%= @project_name_camel_case %>API.Schema`

  2. Mutation resolver calls a function on `<%= @project_name_camel_case %>`, which, if successful,
     broadcasts a regular Elixir event on a topic on `<%= @project_name_camel_case %>.PubSub`.

     - Domains within `<%= @project_name_camel_case %>` can also be subscribing to these
       events for activity feeds, analytics, logging, reporting, etc.

  3. `<%= @project_name_camel_case %>API.PubSub.Repeater` picks up on the event, and repeats it
     on `<%= @project_name_camel_case %>.PubSub %>`, but on an Absinthe-specific topic, and in
     the format that only Absinthe/Phoenix expects.

  This keeps the Absinthe-specific subscription details local to `<%= @project_name_camel_case %>API`,
  allowing `<%= @project_name_camel_case %>` to have zero knowledge or dependency on Phoenix or GraphQL.
  """

  use GenServer

  alias <%= @project_name_camel_case %>.PubSub, warn: false
  alias Absinthe.Subscription, warn: false

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @doc false
  def init(target) do
    # PubSub.subscribe("topic1")
    # PubSub.subscribe("topic2")
    {:ok, target}
  end

  # Each message broadcasted on the watched topics will trigger a handle_info
  # callback like the one below, where `target` is the PubSub server that
  # Absinthe will use.
  #
  # def handle_info({:user_created, user}, target) do
  #   Subscription.publish(target, user, user_created: "*")
  #   {:noreply, target}
  # end
end