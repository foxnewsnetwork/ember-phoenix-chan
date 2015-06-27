defmodule Serve.CameraView do
  use Serve.Web, :view

  def render("index.json", %{cameras: cameras}) do
    %{cameras: render_many(cameras, "camera.json")}
  end

  def render("show.json", %{camera: camera}) do
    %{camera: render_one(camera, "camera.json")}
  end

  def render("camera.json", %{camera: camera}) do
    %{
      id: camera.id,
      name: camera.name,
      address: camera.address,
      digits: camera.digits
    }
  end
end
