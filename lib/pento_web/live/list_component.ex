defmodule PentoWeb.ListComponent do
  use PentoWeb, :live_component

  def render(assigns) do
    ~H"""
    <ul>
      <%= for item <- @items do %>
        <li><%= item %></li>
      <% end %>
    </ul>
    """
  end
end
