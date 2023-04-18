defmodule Firebnb.Booking do
  alias Firebnb.Booking.Like
  alias Firebnb.Booking.Room

  alias Firebnb.Repo

  import Ecto.Query

  def list_rooms() do
    Room
    |> Repo.all()
  end

  @limit 12
  def list_rooms(viewer, filters \\ [], page \\ 1) do
    offset = (page - 1) * @limit

    viewer_id =
      case viewer do
        %{id: id} -> id
        _ -> nil
      end

    base_query = Room

    Enum.reduce(filters, base_query, fn
      {:is_superhost, _}, query -> from room in query, where: room.is_superhost == true
      {:location, location}, query -> from room in query, where: ilike(room.location, ^location)
      _, query -> query
    end)
    |> get_current_user_likes(viewer_id)
    |> limit(@limit)
    |> offset(^offset)
    |> Repo.all()
  end

  defp get_current_user_likes(query, nil), do: query

  defp get_current_user_likes(query, viewer_id) when is_integer(viewer_id) do
    from room in query,
      left_join: like in "likes",
      on: like.room_id == room.id and like.user_id == ^viewer_id,
      select_merge: %{liked_by_me: not is_nil(like.id)}
  end

  def like_room(room, viewer) do
    %Like{room_id: room.id, user_id: viewer.id} |> Repo.insert!()
  end

  def unlike_room(room, viewer) do
    Like
    |> where(room_id: ^room.id, user_id: ^viewer.id)
    |> Repo.delete_all()
  end
end
