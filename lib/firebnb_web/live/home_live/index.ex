defmodule FirebnbWeb.HomeLive.Index do
  use FirebnbWeb, :live_view
  import FirebnbWeb.Components

  alias Firebnb.Booking
  alias FirebnbWeb.RoomComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, suggested_locations: [])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    filters =
      Enum.reduce(params, [], fn
        {"superhost", _}, filters -> filters ++ [superhost: true]
        {"location", location}, filters -> filters ++ [location: location]
        _, filters -> filters
      end)

    rooms = Booking.list_rooms(socket.assigns.current_user, filters)
    socket = stream(socket, :rooms, rooms, reset: true)
    {:noreply, assign(socket, filters: filters)}
  end

  @impl true
  def handle_event("toggle_superhost", _, socket) do
    superhost = !Keyword.get(socket.assigns.filters, :superhost, false)

    filters =
      case superhost do
        true -> add_filter(socket, :superhost, true)
        _ -> remove_filter(socket, :superhost)
      end

    {:noreply, push_patch(socket, to: ~p"/?#{filters}")}
  end

  @impl true
  def handle_event("search", %{"location" => location}, socket) do
    filters =
      case location do
        "" -> remove_filter(socket, :location)
        location -> add_filter(socket, :location, location)
      end

    {:noreply, push_patch(socket, to: ~p"/?#{filters}")}
  end

  @impl true
  def handle_event("location_change", %{"location" => location}, socket) do
    suggested_locations = filter_locations(location)

    {:noreply, assign(socket, :suggested_locations, suggested_locations)}
  end

  @impl true
  def handle_info({:flash, type, message}, socket) do
    {:noreply, put_flash(socket, type, message)}
  end

  defp add_filter(socket, key, value) do
    case socket.assigns[:filters] do
      nil -> [{key, value}]
      filters -> Keyword.put(filters, key, value)
    end
  end

  defp remove_filter(socket, key) do
    case socket.assigns[:filters] do
      nil -> []
      filters -> Keyword.delete(filters, key)
    end
  end

  defp filter_locations(keyword) do
    Booking.list_locations()
    |> Enum.filter(fn location ->
      String.contains?(String.downcase(location), String.downcase(keyword))
    end)
  end
end
