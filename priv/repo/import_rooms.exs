# Script for populating the database with rooms. You can run it as:
#
#     mix run priv/repo/import_rooms.exs

alias NimbleCSV.RFC4180, as: CSV
alias Firebnb.Booking.Room
alias Firebnb.Repo

:code.priv_dir(:firebnb)
|> Path.join("repo/data/rooms.csv")
|> File.read!()
|> CSV.parse_string()
|> Enum.map(fn([sl_no, title, price, location, country, lat_long]) ->
  [{latitude, _}, {longitude, _}] = lat_long |> String.split(",") |> Enum.map(&String.trim/1) |> Enum.map(&Decimal.parse/1)

  %Room{
    title: title,
    description: """
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque accumsan tellus enim, eu egestas ipsum gravida at. Nulla sed fringilla libero. Maecenas euismod maximus purus. Integer sed lacinia tortor. Sed maximus, ligula quis pellentesque efficitur, sem lorem ornare nisl, id aliquam ipsum sem quis ex. Mauris id quam non elit blandit commodo. Donec in posuere arcu. Quisque sagittis, mi vel ultrices pretium, nisl dolor volutpat neque, non pellentesque purus nulla in mi. Pellentesque pellentesque felis vel nunc auctor elementum. Nulla non convallis dui, sit amet aliquam lorem. Morbi egestas dolor bibendum arcu fringilla suscipit. Pellentesque eleifend lacinia mauris id faucibus. Aenean a enim vel nunc bibendum dignissim a quis dui. Cras sodales ex ac diam varius, ac hendrerit velit maximus. Donec euismod nulla sed velit ornare fermentum ut a ipsum. Aliquam erat volutpat.</p>
      <p>Proin ac nisi velit. Cras sodales venenatis ipsum, sit amet aliquet ligula aliquam nec. Aliquam vel porta dolor. Cras nibh tellus, elementum ac elit vitae, pellentesque fermentum mauris. Ut facilisis nisl quis justo tincidunt, non luctus ipsum aliquet. Sed massa risus, semper vitae sollicitudin ac, sollicitudin quis augue. Aliquam lacinia tellus a elementum dapibus. Ut luctus lorem sed nulla semper consequat. In vitae suscipit massa, vitae placerat sapien.</p>
    """,
    price: String.to_integer(price),
    cover_image: "images/rooms/#{sl_no}.webp",
    location: location,
    country: country,
    latitude: latitude,
    longitude: longitude,
    is_superhost: Enum.random(1..7) == 7,
  } |> Repo.insert!()
end)
