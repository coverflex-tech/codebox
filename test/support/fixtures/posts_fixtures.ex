defmodule Codebox.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Codebox.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        summary: "some summary",
        tags: "some tags",
        title: "some title",
        user_id: nil
      })
      |> Codebox.Posts.create_post()

    post
  end
end
