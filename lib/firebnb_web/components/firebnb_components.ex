defmodule FirebnbWeb.Components do
  use Phoenix.Component

  slot :inner_block, required: true

  def price(assigns) do
    ~H"""
    <div class="font-bold text-gray-700">
      €<%= render_slot(@inner_block) %> <span class="font-normal">night</span>
    </div>
    """
  end

  slot :inner_block, required: true

  def room_title(assigns) do
    ~H"""
    <h1 class="pt-3 font-bold text-gray-700 line-clamp-2">
      <%= render_slot(@inner_block) %>
    </h1>
    """
  end

  slot :title, required: true, doc: "Room title"
  slot :price, required: true, doc: "Room price"

  def room(assigns) do
    ~H"""
    <a href="">
      <div>
        <img
          src="/images/rooms/1.webp"
          class="rounded-lg shadow-lg object-none object-center w-80 h-80"
        />
        <h1 class="pt-3 font-bold text-gray-700 line-clamp-2">
          <%= render_slot(@title) %>
        </h1>
      </div>

      <div class="mt-2 text-sm text-gray-600">
        Bangtok &bull; Thailand
        <div class="font-bold text-gray-700">
          €<%= render_slot(@price) %> <span class="font-normal">night</span>
        </div>
      </div>
    </a>
    """
  end
end
