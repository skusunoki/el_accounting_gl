defmodule ExAccounting.Elem.FiscalYear do
  @moduledoc """
  FiscalYear is time period for accounting cycle.
  """
  use Ecto.Type

  @typedoc "_Fiscal Year_ : time period for accounting cycle"
  @type t :: %__MODULE__{fiscal_year: pos_integer}
  defstruct fiscal_year: nil

  @doc """
  Defines the type of the _Fiscal Year_ in database as integer.

  ## Examples

      iex> type()
      :integer

  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
    Generate valid _Fiscal Year_.

  ## Examples

      iex> create(2024)
      %FiscalYear{ fiscal_year: 2024 }
  """
  @spec create(pos_integer) :: t()
  def create(fiscal_year)
      when is_integer(fiscal_year) and fiscal_year > 0 and fiscal_year <= 9999 do
    %__MODULE__{fiscal_year: fiscal_year}
  end

  @doc """
  Casts the given positive integer to the _Fiscal Year_.

  ## Examples

      iex> cast(2024)
      {:ok, %FiscalYear{ fiscal_year: 2024 }}
  """
  @spec cast(pos_integer) :: {:ok, t()} | {:error, pos_integer}
  def cast(term) do
    with true <- is_integer(term),
         true <- term > 0,
         true <- term <= 9999 do
      {:ok, create(term)}
    else
      false -> {:error, term}
    end
  end

  @doc """
  Dumps the _Fiscal Year_ to the integer.

  ## Examples

      iex> dump(%FiscalYear{fiscal_year: 2024})
      {:ok, 2024}

      iex> dump(2024)
      :error

  """
  @spec dump(t) :: {:ok, pos_integer} | :error
  def dump(%__MODULE__{} = term) do
    {:ok, term.fiscal_year}
  end

  def dump(_) do
    :error
  end

  @doc """
  Loads the _Fiscal Year_ from the database form.

  ## Examples

      iex> load(2024)
      {:ok, %FiscalYear{fiscal_year: 2024}}
  """
  @spec load(pos_integer) :: {:ok, t()} | :error
  def load(term) do
    {:ok, create(term)}
  end

  @doc """
  Convert to _Reversed Document Fiscal Year_.

  ## Examples

      iex> to_reversed_document_fiscal_year(%FiscalYear{fiscal_year: 2024})
      {:ok, %ReversedDocumentFiscalYear{ reversed_document_fiscal_year: %FiscalYear{ fiscal_year: 2024 }}}
  """
  @spec to_reversed_document_fiscal_year(t) ::
          {:ok, ExAccounting.Elem.ReversedDocumentFiscalYear.t()} | :error
  def to_reversed_document_fiscal_year(%__MODULE__{} = fiscal_year) do
    ExAccounting.Elem.ReversedDocumentFiscalYear.cast(fiscal_year)
  end
end
