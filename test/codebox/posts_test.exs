defmodule Codebox.PostsTest do
  use Codebox.DataCase

  import Codebox.AccountsFixtures, only: [user_fixture: 0]
  import Codebox.PostsFixtures

  alias Codebox.Posts
  alias Codebox.Posts.Post

  describe "posts" do
    @invalid_attrs %{body: nil, summary: nil, tags: nil, title: nil}

    setup [:setup_user, :setup_post]

    test "list_posts/0 returns all posts", ctx do
      assert Posts.list_posts() == [ctx.post]
    end

    test "get_post!/1 returns the post with given id", ctx do
      post = ctx.post
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post", ctx do
      valid_attrs = %{
        body: "some body",
        summary: "some summary",
        tags: "some tags",
        title: "some title",
        user_id: ctx.user.id
      }

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.body == "some body"
      assert post.summary == "some summary"
      assert post.tags == "some tags"
      assert post.title == "some title"
      assert post.user_id == ctx.user.id
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post", ctx do
      post = ctx.post

      update_attrs = %{
        body: "some updated body",
        summary: "some updated summary",
        tags: "some updated tags",
        title: "some updated title"
      }

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.body == "some updated body"
      assert post.summary == "some updated summary"
      assert post.tags == "some updated tags"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset", ctx do
      post = ctx.post
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post", ctx do
      post = ctx.post
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset", ctx do
      post = ctx.post
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end

  defp setup_user(_ctx) do
    user = user_fixture()

    {:ok, %{user: user}}
  end

  defp setup_post(%{user: user} = _ctx) do
    post = post_fixture(%{user_id: user.id})
    post = Codebox.Repo.preload(post, :user)

    {:ok, %{post: post}}
  end
end
