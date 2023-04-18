defmodule FirebnbWeb.RoomLive.Show do
  use FirebnbWeb, :live_view
  alias Firebnb.Booking
  alias Firebnb.Booking.Reservation

  @broadcast_topic "view_room"

  @impl true
  def mount(_params, _session, socket) do
    FirebnbWeb.Endpoint.subscribe(@broadcast_topic)
    {:ok, assign(socket, form: to_form(Booking.change_reservation(%Reservation{})))}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    room = Booking.get_room(socket.assigns.current_user, id)

    {:noreply, assign(socket, room: room)}
  end

  @impl true
  def handle_event("validate", %{"reservation" => params}, socket) do
    form =
      %Reservation{}
      |> Booking.change_reservation(params)
      |> Map.put(:action, :insert)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"reservation" => reservation_params}, socket) do
    additional_reservation_details = %{
      "price" => socket.assigns.room.price,
      "room_id" => socket.assigns.room.id,
      "user_id" => socket.assigns.current_user.id
    }

    reservation_params = Map.merge(reservation_params, additional_reservation_details)

    case Booking.create_reservation(reservation_params) do
      {:ok, reservation} ->
        FirebnbWeb.Endpoint.broadcast_from(
          self(),
          @broadcast_topic,
          "newbooking",
          socket.assigns.room.id
        )

        {:noreply,
         socket
         |> assign(:reservation, reservation)
         |> put_flash(:info, "reservation created")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  @message "Hurry! This room is on demand. Somone just make a booking to this room. Reserve your booking soon!"
  def handle_info(%{topic: "view_room", event: "newbooking", payload: payload}, socket) do
    if payload == socket.assigns.room.id do
      {:noreply, put_flash(socket, :info, @message)}
    else
      {:noreply, socket}
    end
  end
end
