defmodule ExAccounting.Configuration.AccountingArea.DbGateway do
  import Ecto.Query
  alias ExAccounting.Configuration.AccountingArea

  @spec read() :: [AccountingArea.t()]
  @spec read(ExAccounting.Elem.AccountingArea.t()) ::
          ExAccounting.Configuration.AccountingArea.t()
  def read() do
    AccountingArea
    |> ExAccounting.Repo.all()
    |> ExAccounting.Repo.preload(:accounting_units)
  end

  def read(accounting_area) do
    from(p in ExAccounting.Configuration.AccountingArea,
      where: p.accounting_area == ^accounting_area
    )
    |> ExAccounting.Repo.one()
    |> ExAccounting.Repo.preload(:accounting_units)
  end

end
