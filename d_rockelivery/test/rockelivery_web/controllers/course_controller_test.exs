defmodule RockeliveryWeb.CourseControllerTest do
  use RockeliveryWeb.ConnCase

  import Rockelivery.CoursesFixtures

  alias Rockelivery.Courses.Course

  @create_attrs %{
    title: "some title"
  }
  @update_attrs %{
    title: "some updated title"
  }
  @invalid_attrs %{title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all courses", %{conn: conn} do
      conn = get(conn, ~p"/api/courses")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create course" do
    test "renders course when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/courses", course: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/courses/#{id}")

      assert %{
               "id" => ^id,
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/courses", course: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update course" do
    setup [:create_course]

    test "renders course when data is valid", %{conn: conn, course: %Course{id: id} = course} do
      conn = put(conn, ~p"/api/courses/#{course}", course: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/courses/#{id}")

      assert %{
               "id" => ^id,
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, course: course} do
      conn = put(conn, ~p"/api/courses/#{course}", course: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete course" do
    setup [:create_course]

    test "deletes chosen course", %{conn: conn, course: course} do
      conn = delete(conn, ~p"/api/courses/#{course}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/courses/#{course}")
      end
    end
  end

  defp create_course(_) do
    course = course_fixture()
    %{course: course}
  end
end
