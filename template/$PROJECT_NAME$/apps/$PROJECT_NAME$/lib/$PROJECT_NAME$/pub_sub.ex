<% MixTemplates.ignore_file_unless(assigns[:websockets] != nil) %>
defmodule <%= @project_name_camel_case %>.PubSub do
  @moduledoc """
  The realtime interface for `<%= @project_name_camel_case %>`.

  ## Publishing Messages

  To broadcast a message to all subscribers:

      <%= @project_name_camel_case %>.PubSub.broadcast("topic", {:event, "value"})

  To broadcast to all subscribers except the current process:

      <%= @project_name_camel_case %>.PubSub.broadcast_from(self(), "topic", {:event, "value"})

  ## Subscribing to Messages

  `subscribe/1` will subscribe the current process to messages on a topic.

      <%= @project_name_camel_case %>.PubSub.subscribe("topic")

  Messages will go to the process's mailbox, or the `handle_info` callback if
  the process is a `GenServer`.

  ## Topics & Message Formats

  TODO: document topics and message formats which are broadcasted, like so:

  - topic_name
    - `{:event_name, event_value}`: description of event type
  """

  use Mithril.PubSub, otp_app: :<%= @project_name %>
end