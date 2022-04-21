defmodule CodeboxWeb.PostLiveTest do
  use CodeboxWeb.ConnCase

  import Phoenix.LiveViewTest
  import Codebox.PostsFixtures

  setup :register_and_log_in_user

  @create_attrs %{
    body: "some body",
    summary: "some summary",
    tags: "some tags",
    title: "some title"
  }
  @update_attrs %{
    body: "some updated body",
    summary: "some updated summary",
    tags: "some updated tags",
    title: "some updated title"
  }
  @invalid_attrs %{body: nil, summary: nil, tags: nil, title: nil}

  defp create_post(%{user: user} = _ctx) do
    post = post_fixture(%{user_id: user.id})

    %{post: post}
  end

  describe "Index" do
    setup [:create_post]

    test "lists all posts", %{conn: conn, post: post} do
      {:ok, _index_live, html} = live(conn, Routes.post_index_path(conn, :index))

      assert html =~ post.summary
    end

    test "saves new post", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.post_index_path(conn, :new))

      assert index_live
             |> form("#post-form", post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#post-form", post: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.post_index_path(conn, :index))

      assert html =~ "Post created successfully"
      assert html =~ "some summary"
    end
  end

  describe "Show" do
    setup [:create_post]

    test "displays post", %{conn: conn, post: post} do
      {:ok, _show_live, html} = live(conn, Routes.post_show_path(conn, :show, post))

      assert html =~ "Show Post"
      assert html =~ post.body
    end

    test "updates post within modal", %{conn: conn, post: post} do
      {:ok, show_live, _html} = live(conn, Routes.post_show_path(conn, :show, post))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Post"

      assert_patch(show_live, Routes.post_show_path(conn, :edit, post))

      assert show_live
             |> form("#post-form", post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#post-form", post: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.post_show_path(conn, :show, post))

      assert html =~ "Post updated successfully"
      assert html =~ "some updated body"
    end
  end
end
