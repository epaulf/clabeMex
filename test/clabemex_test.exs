defmodule PracticasTest do
  use ExUnit.Case

  test "is valid" do
    # Bancomer
    assert Clabe.validClabe("012180029656095853") ==
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

    # Bancoppel
    assert Clabe.validClabe("137180103141787480") ==
             {:ok, "is valid", {137, %{fullName: "BanCoppel, S.A.", shortName: "BANCOPPEL"}},
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
  end

  test "invalid Control Digit" do
    assert Clabe.validClabe("012180029656095854") ==
             {:error, "clabe invalid , Control Digit no valid"}
  end

  test "invalid clabe size invalid" do
    assert Clabe.validClabe("01218002965609") ==
             {:error, "clabe invalid , it is alphanumeric or size of clabe not valid"}
  end

  test "invalid clabe alphanumeric" do
    assert Clabe.validClabe("01218002965609A") ==
             {:error, "clabe invalid , it is alphanumeric or size of clabe not valid"}
  end

  test "invalid bank" do
    assert Clabe.validClabe("777180029656095853") == {:error, "clabe invalid , bank no valid"}
  end

  test "invalid citie" do
    assert Clabe.validClabe("012880029656095853") == {:error, "clabe invalid , citye no valid"}
  end
end
