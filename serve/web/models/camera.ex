defmodule Serve.Camera do
  use Serve.Web, :model

  schema "cameras" do
    field :name, :string
    field :address, :string
    field :digits, :decimal

    timestamps
  end

  @required_fields ~w(name address digits)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
