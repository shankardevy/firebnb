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
    <div class="relative">
      <!-- replace class "text-slate-300 hover:text-red-600" with "text-red-600" to toggle between liked and unliked state -->
      <button class={[
        "absolute right-2 top-2",
        "text-slate-300 hover:text-red-600"
      ]}>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 20 20"
          fill="currentColor"
          class="w-5 h-5"
        >
          <path d="M9.653 16.915l-.005-.003-.019-.01a20.759 20.759 0 01-1.162-.682 22.045 22.045 0 01-2.582-1.9C4.045 12.733 2 10.352 2 7.5a4.5 4.5 0 018-2.828A4.5 4.5 0 0118 7.5c0 2.852-2.044 5.233-3.885 6.82a22.049 22.049 0 01-3.744 2.582l-.019.01-.005.003h-.002a.739.739 0 01-.69.001l-.002-.001z" />
        </svg>
      </button>
      <div
        :if={@superhost}
        class="absolute left-2 top-2 rounded-sm bg-slate-100 py-0.5 px-1 text-sm font-bold"
      >
        Superhost
      </div>
      <a href="">
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
    </div>
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
