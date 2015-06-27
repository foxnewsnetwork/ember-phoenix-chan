defmodule Serve.CameraTest do
  use Serve.ModelCase

  alias Serve.Camera

  @valid_attrs %{address: "some content", digits: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Camera.changeset(%Camera{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Camera.changeset(%Camera{}, @invalid_attrs)
    refute changeset.valid?
  end
end
