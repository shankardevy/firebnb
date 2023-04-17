defmodule FirebnbWeb.Components do
  use Phoenix.Component

  def price(assigns) do
    ~H"""
    <div class="font-bold text-gray-700">
      €<%= render_slot(@inner_block) %> <span class="font-normal">night</span>
    </div>
    """
  end

  def room_title(assigns) do
    ~H"""
    <h1 class="pt-3 font-bold text-gray-700 line-clamp-2">
      <%= render_slot(@inner_block) %>
    </h1>
    """
  end

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
