defmodule Clabe do
  @moduledoc """
  Documentation for Clabe.
  """

  @doc """
  Clabe : validates that the interbank account number is real.
  * Only applies for Mexican bank accounts.
  Reference :
  https://www.bancanetempresarial.banamex.com.mx/spanishdir/bankhelp/win_archivoscargosdomicilia.htm
  ## Examples

    VALID : 
      iex(2)> Clabe.validClabe("012180029656095853") ==
             {:ok, "is valid",
              {12, %{fullName: "BBVA Bancomer, S.A.", shortName: "BBVA BANCOMER"}},
              [
                {180, "Atizapan"},
                {180, "Chalco"},
                {180, "Ciudad de México"},
                {180, "Coacalco"},
                {180, "Cuautitlán Izcalli"},
                {180, "Cuautitlán"},
                {180, "Ecatepec"},
                {180, "Huehuetoca"},
                {180, "Huixquilucan"},
                {180, "Ixtapaluca"},
                {180, "Los Reyes La Paz"},
                {180, "Naucalpan"},
                {180, "Nezahualcóyotl"},
                {180, "Tecamac"},
                {180, "Teotihuacán"},
                {180, "Texcoco"},
                {180, "Tlalnepantla"}
              ]}
    INVALID :
      iex(1)> Clabe.validClabe("012180029656095854")
            {:error, "clabe invalid , Control Digit no valid"}
  """
  @spec validClabe(String) :: Tuple
  def validClabe(clabe) do
    case is_numeric(clabe) && clabe |> String.length() == 18 do
      true ->
        bank = clabe |> String.slice(0, 3) |> String.to_integer()
        citie = clabe |> String.slice(3, 3) |> String.to_integer()
        fbank = find_bank(bank)
        cities = find_citie(citie)

        case fbank |> is_nil do
          true ->
            {:error, "clabe invalid , bank no valid"}

          _ ->
            case cities == [] do
              true ->
                {:error, "clabe invalid , citye no valid"}

              _ ->
                case get_control_digit(clabe) == calculate_control_digit(clabe) do
                  true -> {:ok, "is valid", fbank, cities}
                  _ -> {:error, "clabe invalid , Control Digit no valid"}
                end
            end
        end

      _ ->
        {:error, "clabe invalid , it is alphanumeric or size of clabe not valid"}
    end
  end

  @spec get_control_digit(String) :: String
  def get_control_digit(clabe) do
    clabe |> String.slice(17, 18) |> String.to_integer()
  end

  @spec calculate_control_digit(String) :: Integer
  def calculate_control_digit(clabe) do
    cons = [3, 7, 1] |> List.duplicate(6) |> List.flatten()
    numcheck = clabe |> String.slice(0, 17) |> String.graphemes()

    (10 -
       (Enum.with_index(numcheck)
        |> Enum.map(fn {x, y} ->
          {num, _} = Integer.parse(x)

          (num * Enum.at(cons, y))
          |> rem(10)
        end)
        |> Enum.sum()
        |> rem(10)))
    |> rem(10)
  end

  @spec find_bank(Integer) :: Tuple
  def find_bank(bank) do
    Enum.find(Data.banks(), fn element ->
      match?({^bank, _}, element)
    end)
  end

  @spec find_citie(Integer) :: List
  def find_citie(citie) do
    Enum.filter(Data.cities(), fn element ->
      match?({^citie, _}, element)
    end)
  end

  @spec is_numeric(String.t()) :: boolean()
  def is_numeric(number) do
    case Integer.parse(number) do
      {_, ""} -> true
      _ -> false
    end
  end
end
