defmodule Serve.CameraControllerTest do
  use Serve.ConnCase

  alias Serve.Camera
  @valid_attrs %{address: "some content", digits: "120.5", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, camera_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    camera = Repo.insert %Camera{}
    conn = get conn, camera_path(conn, :show, camera)
    assert json_response(conn, 200)["data"] == %{
      "id" => camera.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, camera_path(conn, :create), camera: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Camera, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, camera_path(conn, :create), camera: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    camera = Repo.insert %Camera{}
    conn = put conn, camera_path(conn, :update, camera), camera: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Camera, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    camera = Repo.insert %Camera{}
    conn = put conn, camera_path(conn, :update, camera), camera: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    camera = Repo.insert %Camera{}
    conn = delete conn, camera_path(conn, :delete, camera)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Camera, camera.id)
  end
end
