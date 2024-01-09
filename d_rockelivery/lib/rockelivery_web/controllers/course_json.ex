defmodule RockeliveryWeb.CourseJSON do
  alias Rockelivery.Courses.Course

  @doc """
  Renders a list of courses.
  """
  def index(%{courses: courses}) do
    %{data: for(course <- courses, do: data(course))}
  end

  @doc """
  Renders a single course.
  """
  def show(%{course: course}) do
    %{data: data(course)}
  end

  defp data(%Course{} = course) do
    %{
      id: course.id,
      title: course.title
    }
  end
end
