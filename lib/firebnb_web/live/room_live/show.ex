defmodule FirebnbWeb.RoomLive.Show do
  use FirebnbWeb, :live_view
  alias Firebnb.Booking

  @impl true
  def mount(_params, _session, socket) do
    # Both of these inspect statements will be printed twice
    # if you visit directly `/rooms/{id}` in the browser because
    # this `mount/3` is getting called twice -- First as a GET request
    # and the second as a Websocket request.
    #
    # However, if you visit `/room/{id}` by clicking on the links
    # on the homepage, this `mount/3` function is only called once through
    # Websocket request as this is a navigation from one liveview to another
    # with an existing socket connection.
    IO.inspect "MOUNT IS CALLED", label: "RoomLive mount/3"
    IO.inspect connected?(socket), label: "Is socket connected?"

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    room = Booking.get_room(socket.assigns.current_user, id)

    {:noreply, assign(socket, :room, room)}
  end
end
