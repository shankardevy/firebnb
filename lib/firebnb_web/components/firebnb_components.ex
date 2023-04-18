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

  def toggle_superhost(assigns) do
    ~H"""
    <div class="flex items-center py-6">
      <!-- Enabled: "bg-amber-600", Not Enabled: "bg-gray-200" -->
      <button
        type="button"
        class={[
          "relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-amber-500 focus:ring-offset-2",
          !@superhost && "bg-gray-200",
          @superhost && "bg-amber-600"
        ]}
        role="switch"
        aria-checked="false"
        aria-labelledby="superhost-label"
        phx-click="toggle_superhost"
      >
        <!-- Enabled: "translate-x-5", Not Enabled: "translate-x-0" -->
        <span
          aria-hidden="true"
          class={[
            "pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out",
            !@superhost && "translate-x-0",
            @superhost && "translate-x-5"
          ]}
        >
        </span>
      </button>
      <span class="ml-3" id="superhost-label">
        <span class="text-sm font-medium text-gray-900">
          <%= render_slot(@inner_block) %>
        </span>
      </span>
    </div>
    """
  end
end
