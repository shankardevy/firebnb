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
    IO.inspect("MOUNT IS CALLED", label: "RoomLive mount/3")
    IO.inspect(connected?(socket), label: "Is socket connected?")

    rooms = Booking.list_rooms(socket.assigns.current_user)

    {:ok, assign(socket, rooms: rooms)}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    # Previously, because we moved the loading of the current room being viewed to `mount/3`
    # navigating between one room to another was not changing the content
    # on the browser unless the page was refreshed to make a GET request.
    #
    # The solution to this pitfall is move page specific loading to `handle_params/3`
    # and keep the common data across different pages in `mount/3`.
    # In this case, list of other rooms available is a common data, while
    # the room that is being viewed is page specific data and should be loaded in `handle_params/3`
    # as shown below:

    IO.inspect("handle_params/3 is called", label: "RoomLive")
    room = Booking.get_room(socket.assigns.current_user, id)

    {:noreply, assign(socket, room: room)}
  end
end
