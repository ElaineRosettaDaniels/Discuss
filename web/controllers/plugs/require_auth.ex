defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn # Gives us halt() function
  import Phoenix.Controller # Gives us put_flash and redirect function

  alias Discuss.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do # "if a user exists here..."
      conn # "continue on."
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt() # Must include to tell Phoenix that this conn is done, don't send further down the line
    end
  end
end
