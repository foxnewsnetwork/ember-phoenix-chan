defmodule Serve.Router do
  use Serve.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Serve do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  socket "/ws", Serve do
    channel "cameras:*", CameraChannel
  end
  # Other scopes may use custom stacks.
  scope "/api", Serve do
    pipe_through :api
    resources "/cameras", CameraController, only: [:index, :show, :create, :delete, :update]
  end
end
