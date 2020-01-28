defmodule Discuss.TopicController do
    use Discuss.Web, :controller

    alias Discuss.Topic

    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{}, %{})
        #This line tells us when we're making a new doc, we want to provide the new page w/ our changeset
        render conn, "new.html", changeset: changeset
    end
    # topic is our params
    def create(conn, %{"topic" => topic}) do
        # %Topic{} is an empty struct, we pass in the params: topic
        changeset = Topic.changeset(%Topic{}, topic)

        # We use the Repo module to pass in our changeset
        case Repo.insert(changeset) do
            {:ok, post} -> IO.inspect(post)
            {:error, changeset} -> 
                # we're gonna render the page again with the changeset we had before if we get an error
                render conn, "new.html", changeset: changeset
        end
    end
end