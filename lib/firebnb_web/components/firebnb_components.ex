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
end
