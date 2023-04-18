defmodule Firebnb.Administration.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :description, :string
    field :price, :decimal
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:title, :description, :price])
    |> validate_required([:title, :description, :price])
  end
end
