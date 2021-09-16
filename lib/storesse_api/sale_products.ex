defmodule StoresseApi.SaleProducts do
  @moduledoc """
  The SaleProducts context.
  """

  import Ecto.Query, warn: false
  alias StoresseApi.Repo

  alias StoresseApi.SaleProducts.SaleProduct

  @doc """
  Returns the list of sale_products.

  ## Examples

      iex> list_sale_products()
      [%SaleProduct{}, ...]

  """
  def list_sale_products do
    Repo.all(SaleProduct)
  end

  @doc """
  Gets a single sale_product.

  Raises `Ecto.NoResultsError` if the Sale product does not exist.

  ## Examples

      iex> get_sale_product!(123)
      %SaleProduct{}

      iex> get_sale_product!(456
      ** (Ecto.NoResultsError)

  """
  
  def get_sale_product!(id) do
  SaleProduct
  |> Repo.get!(id)
  |> Repo.preload(:product)
  end
  
  def get_sale_products_for_sale!(sale_id) do
    sale_products = from sp in SaleProduct, where: sp.sale_id == ^sale_id
    Repo.all(sale_products)
  end

  @doc """
  Creates a sale_product.

  ## Examples

      iex> create_sale_product(%{field: value})
      {:ok, %SaleProduct{}}

      iex> create_sale_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sale_product(attrs \\ %{}) do
    %SaleProduct{}
    |> SaleProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sale_product.

  ## Examples

      iex> update_sale_product(sale_product, %{field: new_value})
      {:ok, %SaleProduct{}}

      iex> update_sale_product(sale_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sale_product(%SaleProduct{} = sale_product, attrs) do
    sale_product
    |> SaleProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sale_product.

  ## Examples

      iex> delete_sale_product(sale_product)
      {:ok, %SaleProduct{}}

      iex> delete_sale_product(sale_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sale_product(%SaleProduct{} = sale_product) do
    Repo.delete(sale_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sale_product changes.

  ## Examples

      iex> change_sale_product(sale_product)
      %Ecto.Changeset{data: %SaleProduct{}}

  """
  def change_sale_product(%SaleProduct{} = sale_product, attrs \\ %{}) do
    SaleProduct.changeset(sale_product, attrs)
  end
end
