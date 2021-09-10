# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# The first time you run the script the rows should be inserted into the
# database without issue. But subsequent runs will error due to the duplicate
# SKUs unless you clean the database first.
#
# The script is not using the ! versions of the repo functions so each
# individual database execution may or may not fail.

alias Pento.Catalog

products = [
  %{
    name: "Chess",
    description: "64 squares, 32 pieces, 2 players, 1 game",
    sku: 5_678_910,
    unit_price: 10.00
  },
  %{
    name: "Tic-Tac-Toe",
    description: "The classic game of Xs and Os",
    sku: 11_112_113,
    unit_price: 3.00
  },
  %{
    name: "Table Tennis",
    description: "Tennis but table sized",
    sku: 21_012_34,
    unit_price: 12.00
  }
]

products
|> Enum.each(&Catalog.create_product/1)
