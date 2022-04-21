defmodule CodeboxWeb.PostLive.Show do
  use CodeboxWeb, :live_view

  alias Codebox.Posts

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign_current_user(socket, session)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    post = Posts.get_post!(id)

    if socket.assigns.live_action == :show or
         (socket.assigns.live_action == :edit and can_edit?(socket, post)) do
      {:noreply,
       socket
       |> assign(:page_title, page_title(socket.assigns.live_action))
       |> assign(:post, post)}
    else
      {:noreply,
       socket
       |> put_flash(:error, "You do not have the required permissions to do that!")
       |> push_redirect(to: Routes.post_show_path(socket, :show, id))}
    end
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Posts.get_post!(id)

    if can_edit?(socket, post) do
      {:ok, _} = Posts.delete_post(post)

      {:noreply,
       socket
       |> put_flash(:info, "Post deleted successfully!")
       |> push_redirect(to: Routes.post_index_path(socket, :index))}
    else
      {:noreply,
       socket
       |> put_flash(:error, "You do not have the required permissions to do that!")
       |> push_redirect(to: Routes.post_show_path(socket, :show, id))}
    end
  end

  defp can_edit?(socket, post) do
    post.user_id == socket.assigns.current_user.id
  end

  defp page_title(:show), do: "Show Post"
  defp page_title(:edit), do: "Edit Post"
end
