defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :user_id, references(:users) # References the :users table in DB, sort of like a foreign key. Maybe exactly that.
    end
  end
end
