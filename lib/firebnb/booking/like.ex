defmodule Firebnb.Booking.Like do
  use Ecto.Schema
  import Ecto.Changeset

  schema "likes" do

    field :room_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [])
    |> validate_required([])
  end
end
