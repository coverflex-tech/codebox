defmodule Codebox.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Codebox.Accounts.User

  schema "posts" do
    field :body, :string
    field :summary, :string
    field :tags, :string
    field :title, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :summary, :body, :tags, :user_id])
    |> validate_required([:title, :summary, :body, :user_id])
  end
end
