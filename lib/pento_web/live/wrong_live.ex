defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @upper 10

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number",
        winning: :rand.uniform(@upper)
      )
    }
  end

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2><%= @message %></h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}=data, socket) do
    IO.inspect data
    { guess, _ } = Integer.parse(guess)
    if guess == socket.assigns.winning do
      message = "You guessed #{guess}. That's right!"
      score = socket.assigns.score + 1
      { :noreply, assign(socket, message: message, score: score) }
    else
      message = "You guessed #{guess}. That is incorrect. Try again?"
      { :noreply, assign(socket, message: message) }
    end
  end
end
