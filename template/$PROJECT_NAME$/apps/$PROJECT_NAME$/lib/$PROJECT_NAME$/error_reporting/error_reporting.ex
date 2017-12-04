defmodule <%= @project_name_camel_case %>.ErrorReporting do
  @moduledoc """
  Provides error reporting functionality to <%= assigns[:error_reporting] %>

  ### Usage

  1. Notify Honeybadger of an Error

     ```elixir
     <%= @project_name_camel_case %>.ErrorReporting.notify(error, %{user_email: "johndoe@example.com"})
     ```

  2. Set Honeybadger Context

     ```elixir
     <%= @project_name_camel_case %>.ErrorReporting.context(%{user_email: "johndoe@example.com"})
     ```
  """
  alias Honeybadger

  @doc """
  Function to notify <%= assigns[:error_reporting] %> of an error.

  ## Examples

      # Notify with Context
      <%= @project_name_camel_case %>.ErrorReporting.notify(error, %{user_email: "johndoe@example.com"})

      # Notify with default context
      <%= @project_name_camel_case %>.ErrorReporting.notify(error)
  """
  def notify(error, context \\ %{}) do
    Honeybadger.notify(error, context)
  end

  @doc """
  Function to set <%= assigns[:error_reporting] %> context.

  ## Examples

      # Notify
      <%= @project_name_camel_case %>.ErrorReporting.context(%{user_email: "johndoe@example.com"})
  """
  def context(context) do
    Honeybadger.context(context)
  end
end