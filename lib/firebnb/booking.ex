defmodule Firebnb.Booking do
  alias Firebnb.Booking.Room
  alias Firebnb.Repo

  import Ecto.Query

  def list_rooms() do
    Room
    |> Repo.all()
  end

  def list_rooms(filters) do
    base_query = Room

    Enum.reduce(filters, base_query, fn
      {:is_superhost, _}, query -> from room in query, where: room.is_superhost == true
      {:location, location}, query -> from room in query, where: ilike(room.location, ^location)
      _, query -> query
    end)
    |> Repo.all()
  end
end
