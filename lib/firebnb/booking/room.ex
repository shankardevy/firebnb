defmodule Firebnb.Booking.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :cover_image, :string
    field :description, :string
    field :latitude, :decimal
    field :longitude, :decimal
    field :location, :string
    field :country, :string
    field :price, :integer
    field :title, :string
    field :is_superhost, :boolean
    field :liked_by_me, :boolean, virtual: true

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:cover_image, :title, :description, :price, :latitude, :longitude])
    |> validate_required([:cover_image, :title, :description, :price, :latitude, :longitude])
  end
end
