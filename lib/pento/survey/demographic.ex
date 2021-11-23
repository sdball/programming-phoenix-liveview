defmodule Pento.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Account.User

  schema "demographics" do
    field :year_of_birth, :integer
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:year_of_birth, :user_id])
    |> validate_required([:year_of_birth, :user_id])
    |> validate_inclusion(:year_of_birth, 1900..Date.utc_today.year)
    |> unique_constraint(:user_id)
  end
end
