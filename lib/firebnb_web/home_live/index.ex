defmodule FirebnbWeb.HomeLive.Index do
  use FirebnbWeb, :live_view
  import FirebnbWeb.Components

  alias Firebnb.Booking

  def mount(_params, _session, socket) do
    rooms = Booking.list_rooms()

    {:ok, assign(socket, rooms: rooms, clicks: 0)}
  end

  def handle_event("click", _params, socket) do
    clicks = socket.assigns.clicks + 1
    {:noreply, assign(socket, clicks: clicks)}
  end
end
