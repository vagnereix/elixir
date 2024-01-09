defmodule Rockelivery.CoursesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rockelivery.Courses` context.
  """

  @doc """
  Generate a course.
  """
  def course_fixture(attrs \\ %{}) do
    {:ok, course} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Rockelivery.Courses.create_course()

    course
  end
end
