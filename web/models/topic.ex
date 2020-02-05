defmodule Discuss.Topic do
    use Discuss.Web, :model
    # update
    schema "topics" do
        field :title, :string
        belongs_to :user, Discuss.User # Says this instance belongs to a thing--a *user*, and an instance of that user is from Discuss.User
    end


    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title])
        |> validate_required([:title])
    end
end
