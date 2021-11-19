defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view
  alias Pento.Search
  alias Pento.Search.Query

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_query() |> assign(:results, []) |> assign_changeset()}
  end

  def assign_query(socket) do
    socket |> assign(:query, %Query{})
  end

  def assign_changeset(socket) do
    assign_changeset(socket, Search.change_query(socket.assigns.query))
  end

  def assign_changeset(socket, changeset) do
    socket |> assign(:changeset, changeset)
  end

  def handle_event("validate", %{"query" => query_params}, socket) do
    changeset =
      socket.assigns.query |> Search.change_query(query_params) |> Map.put(:action, :validate)

    {:noreply, socket |> assign_changeset(changeset)}
  end

  def handle_event("submit", %{"query" => query_params}, socket) do
    case Search.submit(socket.assigns.query, query_params) do
      {:ok, results} ->
        {:noreply, socket |> assign(:results, results)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:changeset, changeset |> Map.put(:action, :validate))}
    end
  end
end
