defmodule Firebnb.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :cover_image, :string
      add :title, :string
      add :description, :text
      add :price, :integer
      add :location, :string
      add :country, :string
      add :latitude, :decimal
      add :longitude, :decimal
      add :is_superhost, :boolean

      timestamps()
    end
  end
end
