defmodule <%= @project_name_camel_case %>.ErrorReporting.Filter do
  @moduledoc """
  An implementation of `Honeybadger.Filter`.

  If you need to implement custom filtering for one or more of the elements in
  a `Honeybadger.Notice`, you can do so here.

  E.g., if you wanted to filter the error message string, but
  keep all of the other default filtering, you could do:

      ```elixir
      def filter_error_message(message) do
        # replace passwords in error message with `"xxx"`
        Regex.replace(~r/(password:\s*)"([^"]+)"/, message, ~s(\\1"xxx"))
      end
      ```

  See the documentation for `Honeybadger.Filter` for a list of functions that
  may be overridden.  The default implementations for all of the functions that
  take a `map` are to remove any keys from the map that match a key in
  `filter_keys`. The check matches atoms and strings in a case insensitive
  manner.
  """

  use Honeybadger.Filter.Mixin

end