defmodule Serve.CameraChannel do
  use Serve.Web, :channel

  def join("cameras:adds", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("cameras:changes", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("cameras:removes", _auth_msg, socket) do
    {:ok, socket}
  end

end
