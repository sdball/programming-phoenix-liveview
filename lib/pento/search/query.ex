defmodule Pento.Search.Query do
  defstruct [:sku]
  @types %{sku: :string}

  alias Pento.Search.Query

  import Ecto.Changeset

  def changeset(%Query{} = query, attrs) do
    {query, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(:sku)
    |> validate_length(:sku, min: 7, max: 7)
  end
end
