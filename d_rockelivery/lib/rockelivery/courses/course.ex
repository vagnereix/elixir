defmodule Rockelivery.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "courses" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
