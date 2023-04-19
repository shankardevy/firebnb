defmodule FirebnbWeb.Components do
  use Phoenix.Component

  def price(assigns) do
    ~H"""
    <div class="font-bold text-gray-700">
      €<%= @amount %> <span class="font-normal">night</span>
    </div>
    """
  end
end
