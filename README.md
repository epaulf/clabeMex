# Clabemex

**Validate interbank account number (Clabe) in Elixir**

## Installation

The package can be installed
by adding `clabemex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:clabemex, "~> 0.1.0"}
  ]
end
```

## Examples

```bash
Clabe.validClabe("012180029656095853")
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

ex(1)> Clabe.validClabe("137180103141787480")
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

 iex(2)> Clabe.validClabe("137180103141787483")
{:error, "clabe invalid , Control Digit no valid"}

iex(3)> Clabe.validClabe("937180103141787480")
{:error, "clabe invalid , bank no valid"}

iex(7)> Clabe.validClabe("137980103141787480")
{:error, "clabe invalid , citye no valid"}

```
