defmodule FirebnbWeb.RoomLive.Show do
  use FirebnbWeb, :live_view
  alias Firebnb.Booking

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    room = Booking.get_room(socket.assigns.current_user, id)

    {:noreply, assign(socket, room: room)}
  end
end
