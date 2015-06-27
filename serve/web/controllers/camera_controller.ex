defmodule Serve.CameraController do
  use Serve.Web, :controller

  alias Serve.Camera

  plug :scrub_params, "camera" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    cameras = Repo.all(Camera)
    render(conn, "index.json", cameras: cameras)
  end

  def create(conn, %{"camera" => camera_params}) do
    changeset = Camera.changeset(%Camera{}, camera_params)

    if changeset.valid? do
      camera = Repo.insert(changeset)
      Serve.Endpoint.broadcast! "cameras:adds", "new", %{camera: camera}
      render(conn, "show.json", camera: camera)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Serve.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    camera = Repo.get!(Camera, id)
    render conn, "show.json", camera: camera
  end

  def update(conn, %{"id" => id, "camera" => camera_params}) do
    camera = Repo.get!(Camera, id)
    changeset = Camera.changeset(camera, camera_params)

    if changeset.valid? do
      camera = Repo.update(changeset)
      Serve.Endpoint.broadcast! "cameras:changes", "#{camera.id}", %{camera: camera}
      render(conn, "show.json", camera: camera)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Serve.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    camera = Repo.get!(Camera, id)

    camera = Repo.delete!(camera)
    Serve.Endpoint.broadcast! "cameras:removes", "#{camera.id}", %{camera: camera}
    render(conn, "show.json", camera: camera)
  end
end
