defmodule FirebnbWeb.RoomComponent do
  use FirebnbWeb, :live_component

  alias Firebnb.Booking

  @impl true
  def render(assigns) do
    ~H"""
    <div class="relative">
      <!-- replace class "text-slate-300 hover:text-red-600" with "text-red-600" to toggle between liked and unliked state -->
      <button
        class={[
          "absolute right-2 top-2",
          !@room.liked_by_me && "text-slate-300 hover:text-red-600",
          @room.liked_by_me && "text-red-600"
        ]}
        phx-click="toggle_like"
        phx-target={@myself}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 20 20"
          fill="currentColor"
          class="w-5 h-5"
        >
          <path d="M9.653 16.915l-.005-.003-.019-.01a20.759 20.759 0 01-1.162-.682 22.045 22.045 0 01-2.582-1.9C4.045 12.733 2 10.352 2 7.5a4.5 4.5 0 018-2.828A4.5 4.5 0 0118 7.5c0 2.852-2.044 5.233-3.885 6.82a22.049 22.049 0 01-3.744 2.582l-.019.01-.005.003h-.002a.739.739 0 01-.69.001l-.002-.001z" />
        </svg>
      </button>
      <div
        :if={@room.is_superhost}
        class="absolute left-2 top-2 rounded-sm bg-slate-100 py-0.5 px-1 text-sm font-bold"
      >
        Superhost
      </div>
      <a href="">
        <div>
          <img
            src={@room.cover_image}
            class="rounded-lg shadow-lg object-none object-center w-80 h-80"
          />
          <h1 class="pt-3 font-bold text-gray-700 line-clamp-2">
            <%= @room.title %>
          </h1>
        </div>

        <div class="mt-2 text-sm text-gray-600">
          <%= @room.location %> &bull; <%= @room.country %>
          <div class="font-bold text-gray-700">
            €<%= @room.price %> <span class="font-normal">night</span>
          </div>
        </div>
      </a>
    </div>
    """
  end

  @impl true
  def handle_event("toggle_like", _, socket) do
    like = !socket.assigns.room.liked_by_me

    case like do
      true -> {:noreply, like_room(socket)}
      _ -> {:noreply, unlike_room(socket)}
    end
  end

  defp like_room(%{assigns: %{room: room, viewer: viewer}} = socket) do
    Booking.like_room(room, viewer)
    room = %{room | liked_by_me: true}
    assign(socket, :room, room)
  end

  defp unlike_room(%{assigns: %{room: room, viewer: viewer}} = socket) do
    Booking.unlike_room(room, viewer)
    room = %{room | liked_by_me: false}
    assign(socket, :room, room)
  end
end
