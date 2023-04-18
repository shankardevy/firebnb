defmodule Firebnb.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :price, :integer
      add :checkin, :date
      add :checkout, :date
      add :guests, :integer
      add :room_id, references(:rooms, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:reservations, [:room_id])
    create index(:reservations, [:user_id])
  end
end
