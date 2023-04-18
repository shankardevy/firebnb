defmodule FirebnbWeb.HomeLive.Index do
  use FirebnbWeb, :live_view
  import FirebnbWeb.Components

  alias Firebnb.Booking
  alias FirebnbWeb.RoomComponent

  def mount(_params, _session, socket) do
    rooms = Booking.list_rooms(socket.assigns.current_user)

    {:ok, assign(socket, rooms: rooms, superhost: false)}
  end

  def handle_event("toggle_superhost", _, socket) do
    superhost = !socket.assigns.superhost

    filters =
      case superhost do
        true -> [{:is_superhost, true}]
        _ -> []
      end

    rooms = Booking.list_rooms(socket.assigns.current_user, filters)

    {:noreply, assign(socket, superhost: superhost, rooms: rooms)}
  end
end
