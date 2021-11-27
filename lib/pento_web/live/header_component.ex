defmodule PentoWeb.HeaderComponent do
  use PentoWeb, :live_component

  def render(assigns) do
    ~H"""
    <%= content_tag @heading do %>
      <%= @contents %>
    <% end %>
    """
  end
end
