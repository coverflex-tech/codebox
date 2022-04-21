defmodule CodeboxWeb.PostLive.Index do
  use CodeboxWeb, :live_view

  alias Codebox.Posts
  alias Codebox.Posts.Post

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:posts, list_posts())
      |> assign_current_user(session)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    post = Posts.get_post!(id)

    if post.user_id == socket.assigns.current_user.id do
      socket
      |> assign(:page_title, "Edit Post")
      |> assign(:post, post)
    else
      socket
      |> put_flash(:error, "You do not have the required permissions to do that!")
      |> push_redirect(to: Routes.post_show_path(socket, :show, id))
    end
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  defp list_posts do
    Posts.list_posts()
  end
end
