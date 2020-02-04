defmodule Discuss.TopicController do
    use Discuss.Web, :controller

    alias Discuss.Topic
    # When calling a Plug, don't include underscore fo file name. Just do like this.
    plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete] # Everything starting at 'when' is called a GUARD CLAUSE; used to tell which functions should go thru this RequireAuth

    def index(conn, _params) do
        topics = Repo.all(Topic)
        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{}, %{})
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do

        changeset = Topic.changeset(%Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Created") # put_flash displays a message that will be shown to the user once, then go away after refresh
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic # we need this 'topic: topic' at the end to get the right ID we're working with
    end

    def update(conn, %{"id" => topic_id, "topic" => topic}) do
        old_topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(old_topic, topic)

        case Repo.update(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Updated")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "edit.html", changeset: changeset, topic: old_topic
        end
    end

    def delete(conn, %{"id" => topic_id}) do
        Repo.get!(Topic, topic_id)
        |> Repo.delete!

        conn
        |> put_flash(:info, "Topic Deleted")
        |> redirect(to: topic_path(conn, :index))
    end

end
