defmodule Firebnb.Booking.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :price, :integer
    field :checkin, :date
    field :checkout, :date
    field :guests, :integer
    field :room_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(reservation, attrs) do
    reservation
    |> cast(attrs, [:checkin, :checkout, :guests, :price, :user_id, :room_id])
    |> validate_required([:checkin, :checkout, :guests, :price, :user_id, :room_id])
    |> validate_checkin_fields()
  end

  def validate_checkin_fields(changeset) do
    checkin = get_field(changeset, :checkin)
    checkout = get_field(changeset, :checkout)

    if checkin && checkout &&
         (Date.compare(checkout, checkin) == :lt || Date.compare(checkout, checkin) == :eq) do
      add_error(changeset, :checkout, "Checkout date cannot be less than or equal to checkin")
    else
      changeset
    end
  end
end
