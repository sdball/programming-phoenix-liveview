defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @upper 10

  def mount(_params, session, socket) do
    {
      :ok,
      socket
      |> assign(
        score: 0,
        guesses: 0,
        message: "Guess a number",
        user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
        session_id: session["live_socket_id"]
      )
      |> assign(percentage: winning_percentage(0, 0))
      |> assign_random_winning
    }
  end

  def assign_random_winning(socket) do
    socket |> assign(winning: :rand.uniform(@upper))
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %>/<%= @guesses %> (<%= @percentage %>%)</h1>
    <h2><%= @message %></h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    <pre>
      <%= @user.email %>
      <%= @session_id %>
    </pre>
    """
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    {guess, _} = Integer.parse(guess)

    guesses = socket.assigns.guesses + 1
    socket = assign(socket, guesses: guesses)

    if guess == socket.assigns.winning do
      message = "You guessed #{guess}. That's right!"
      score = socket.assigns.score + 1
      {:noreply, assign(socket, message: message, score: score, percentage: winning_percentage(score, guesses)) |> assign_random_winning}
    else
      message = "You guessed #{guess}. That is incorrect. Try again?"
      {:noreply, assign(socket, message: message, percentage: winning_percentage(socket.assigns.score, guesses))}
    end
  end

  defp winning_percentage(score, 0) do
    0.00
  end

  defp winning_percentage(score, guesses) do
    IO.inspect(score)
    IO.inspect(guesses)
    score/guesses * 100 |> Float.round(2)
  end
end
