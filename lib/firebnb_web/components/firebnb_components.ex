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
  slot :location, required: true, doc: "Room location"
  attr :superhost, :boolean, default: false

  slot :cover_image, required: true do
    attr :src, :string, required: true
  end

  def room(assigns) do
    ~H"""
    <a href="" class="relative">
      <div
        :if={@superhost}
        class="absolute left-2 top-2 rounded-sm bg-slate-100 py-0.5 px-1 text-sm font-bold"
      >
        Superhost
      </div>
      <div>
        <img
          :for={image <- @cover_image}
          src={image.src}
          class="rounded-lg shadow-lg object-none object-center w-80 h-80"
        />
        <h1 class="pt-3 font-bold text-gray-700 line-clamp-2">
          <%= render_slot(@title) %>
        </h1>
      </div>

      <div class="mt-2 text-sm text-gray-600">
        <%= render_slot(@location) %>
        <div class="font-bold text-gray-700">
          €<%= render_slot(@price) %> <span class="font-normal">night</span>
        </div>
      </div>
    </a>
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
          "bg-gray-200"
        ]}
        role="switch"
        aria-checked="false"
        aria-labelledby="superhost-label"
      >
        <!-- Enabled: "translate-x-5", Not Enabled: "translate-x-0" -->
        <span
          aria-hidden="true"
          class={[
            "pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out",
            "translate-x-0"
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
