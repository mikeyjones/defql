defmodule Defql.Macros.Defdelete do
  @moduledoc false

  alias Defql.Connection

  @doc false
  defmacro defdelete(_name_params, opts \\ [])
  @doc false
  defmacro defdelete({name, _, params}, opts) when is_atom(name) and is_list(params) and length(params) == 1 do
    [first | _] = params
    quote do
      def unquote(name)(unquote_splicing(params)) do
        Connection.delete(
                            resolve_table(unquote(opts)),
                            unquote(first)
                          )
      end
    end
  end

  @doc false
  defmacro defdelete(_, _) do
    quote location: :keep do
      raise ArgumentError, "wrong arguments"
    end
  end
end
