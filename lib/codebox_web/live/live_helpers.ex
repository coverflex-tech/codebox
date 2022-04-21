defmodule CodeboxWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Looks for a `user_token` in the given `session`, queries the database for a
  `user` with that `token` and assigns it to the given `socket`.
  """
  def assign_current_user(socket, %{"user_token" => token} = _session) do
    case Codebox.Accounts.get_user_by_session_token(token) do
      %Codebox.Accounts.User{} = user -> assign(socket, :current_user, user)
      _other -> raise "User with session token '#{inspect(token)}' not found"
    end
  end

  def assign_current_user(socket, _session) do
    assign(socket, :current_user, nil)
  end

  def format_date_time(datetime) do
    Timex.format!(datetime, "{YYYY}-{0M}-{0D} {h24}:{m}")
  end

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.post_index_path(@socket, :index)}>
        <.live_component
          module={CodeboxWeb.PostLive.FormComponent}
          id={@post.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.post_index_path(@socket, :index)}
          post: @post
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="phx-modal fade-in" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="phx-modal-content fade-in-scale"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch "✖",
            to: @return_to,
            id: "close",
            class: "phx-modal-close",
            phx_click: hide_modal()
          %>
        <% else %>
          <a id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}>✖</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
