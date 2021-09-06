defmodule Pento.Repo.Migrations.AddUsername do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: false, default: "-"
    end

    execute "UPDATE users set username=email"

    create unique_index(:users, [:username])
  end
end
