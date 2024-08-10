defmodule ExAccounting.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:user_name, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:user_name])
    |> unique_constraint(:user_name)
  end
end
