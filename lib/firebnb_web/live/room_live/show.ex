defmodule FirebnbWeb.RoomLive.Show do
  use FirebnbWeb, :live_view
  alias Firebnb.Booking

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    # Both of these inspect statements will be printed twice
    # if you visit directly `/rooms/{id}` in the browser because
    # this `mount/3` is getting called twice -- First as a GET request
    # and the second as a Websocket request.
    #
    # However, if you visit `/room/{id}` by clicking on the links
    # on the homepage, this `mount/3` function is only called once through
    # Websocket request as this is a navigation from one liveview to another
    # with an existing socket connection.
    IO.inspect("MOUNT IS CALLED", label: "RoomLive mount/3")
    IO.inspect(connected?(socket), label: "Is socket connected?")

    room = Booking.get_room(socket.assigns.current_user, id)
    rooms = Booking.list_rooms(socket.assigns.current_user)

    {:ok, assign(socket, room: room, rooms: rooms)}
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    # Because we moved the loading of the current room being viewed to `mount/3`
    # navigating between one room to another will not change the content
    # on the browser unless the page is refreshed to make a GET request.
    #
    # Check the next commit for the solution.
    IO.inspect("handle_params/3 is called", label: "RoomLive")
    {:noreply, socket}
  end
end
