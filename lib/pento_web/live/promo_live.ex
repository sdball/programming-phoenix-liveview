defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view
  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_recipient()
     |> assign_changeset()}
  end

  def assign_recipient(socket) do
    socket
    |> assign(:recipient, %Recipient{})
  end

  def assign_changeset(socket) do
    socket
    |> assign(:changeset, Promo.change_recipient(socket.assigns.recipient))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        socket
      ) do
    changeset =
      socket.assigns.recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end

  def handle_event("save", %{"recipient" => recipient_params}, socket) do
    :timer.sleep(500) # allow time to demonstrate the "Sending promo" button change
    case Promo.send_promo(socket.assigns.recipient, recipient_params) do
      {:ok, recipient} ->
        {:noreply,
         socket
         |> clear_flash
         |> put_flash(:info, "Promo sent to #{recipient.changes.first_name} <#{recipient.changes.email}>")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> clear_flash
         |> put_flash(:error, "Failed to send promo")
         |> assign(:changeset, changeset |> Map.put(:action, :validate))}
    end
  end
end
