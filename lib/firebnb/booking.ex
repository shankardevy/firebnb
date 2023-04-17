defmodule Firebnb.Booking do
  alias Firebnb.Booking.Room
  alias Firebnb.Repo

  def list_rooms() do
    Room
    |> Repo.all()
  end
end
