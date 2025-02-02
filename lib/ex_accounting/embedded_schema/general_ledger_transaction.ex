defmodule ExAccounting.EmbeddedSchema.GeneralLedgerTransaction do
  @moduledoc """
  _General Ledger Transaction_ is the transaction that is recorded in the general ledger.
  """
  alias ExAccounting.EmbeddedSchema.GeneralLedgerTransaction.Impl
  use Ecto.Schema

  @type t :: %__MODULE__{
          accounting_area: ExAccounting.Elem.AccountingArea.t(),
          accounting_unit: ExAccounting.Elem.AccountingUnit.t(),
          profit_center: ExAccounting.Elem.ProfitCenter.t(),
          fiscal_year: ExAccounting.Elem.FiscalYear.t(),
          accounting_period: ExAccounting.Elem.AccountingPeriod.t(),
          posting_date: ExAccounting.Elem.PostingDate.t(),
          general_ledger_account: ExAccounting.Elem.GeneralLedgerAccount.t(),
          general_ledger_account_transaction_type:
            ExAccounting.Elem.GeneralLedgerAccountTransactionType.t(),
          debit_credit: ExAccounting.Elem.DebitCredit.t(),
          accounting_document_number: ExAccounting.Elem.AccountingDocumentNumber.t(),
          accounting_document_item_number: ExAccounting.Elem.AccountingDocumentItemNumber.t(),
          transaction_value: ExAccounting.EmbeddedSchema.Money.t(),
          accounting_area_value: ExAccounting.EmbeddedSchema.Money.t(),
          accounting_unit_value: ExAccounting.EmbeddedSchema.Money.t()
        }

  @primary_key false
  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:profit_center, ExAccounting.Elem.ProfitCenter)
    field(:fiscal_year, ExAccounting.Elem.FiscalYear)
    field(:accounting_period, ExAccounting.Elem.AccountingPeriod)
    field(:posting_date, ExAccounting.Elem.PostingDate)
    field(:general_ledger_account, ExAccounting.Elem.GeneralLedgerAccount)

    field(
      :general_ledger_account_transaction_type,
      ExAccounting.Elem.GeneralLedgerAccountTransactionType
    )

    field(:debit_credit, ExAccounting.Elem.DebitCredit)
    field(:accounting_document_number, ExAccounting.Elem.AccountingDocumentNumber)
    field(:accounting_document_item_number, ExAccounting.Elem.AccountingDocumentItemNumber)
    embeds_one(:transaction_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_area_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_unit_value, ExAccounting.EmbeddedSchema.Money)
  end

  @doc """
  Creates a new _General Ledger Transaction_ with the given account and type.

  ## Examples

      iex> with {:ok, account} = ExAccounting.Elem.GeneralLedgerAccount.cast("0001001"),
      ...>      {:ok, type}    = ExAccounting.Elem.GeneralLedgerAccountTransactionType.cast("100") do
      ...>   new(account, type)
      ...> end
      %ExAccounting.EmbeddedSchema.GeneralLedgerTransaction{
        general_ledger_account: %ExAccounting.Elem.GeneralLedgerAccount{general_ledger_account: ~c"0001001"},
        general_ledger_account_transaction_type: %ExAccounting.Elem.GeneralLedgerAccountTransactionType{general_ledger_account_transaction_type: ~c"100"}
      }
  """
  def new(account, type) do
    # TODO: Implement this function

    %__MODULE__{
      general_ledger_account: account,
      general_ledger_account_transaction_type: type
    }
  end

  @doc """
  Builds a changeset of General Ledger Transaction from the `params`.


  """
  @spec changeset(t, map) :: Ecto.Changeset.t()
  defdelegate changeset(general_ledger_transaction, params), to: Impl

  def reverse(%__MODULE__{} = transaction) do
    %__MODULE__{
      general_ledger_account: transaction.general_ledger_account,
      general_ledger_account_transaction_type:
        reverse(transaction.general_ledger_account_transaction_type)
    }
  end

  def reverse(type) do
    case type do
      :opening_balance -> :opening_balance
      :debit_posting -> :credit_posting
      :credit_posting -> :debit_posting
      _ -> :error
    end
  end
end
