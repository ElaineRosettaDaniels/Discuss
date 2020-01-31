defmodule Discuss.User do
    use Discuss.Web, :model

    schema "users" do
        field :email, :string
        field :provider, :string
        field :token, :string

        timestamp()
    end

    

end