defmodule Pento.Search do
  alias Pento.Search.Query
  alias Pento.Catalog

  def change_query(%Query{} = query, attrs \\ %{}) do
    Query.changeset(query, attrs)
  end

  def submit(query, attrs) do
    changeset = change_query(query, attrs)
    if changeset.valid? do
      {:ok, Catalog.search_product_sku(changeset.changes.sku)}
    else
      {:error, changeset}
    end
  end
end
