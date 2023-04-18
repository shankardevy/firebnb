defmodule FirebnbWeb.HomeLive.Index do
  use FirebnbWeb, :live_view
  import FirebnbWeb.Components

  alias Firebnb.Booking

  def mount(_params, _session, socket) do
    rooms = Booking.list_rooms()

    {:ok, assign(socket, rooms: rooms)}
  end
end
