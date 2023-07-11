# Ignite Elixir - Módulo 01

## Funções one line

Podemos criar funções em uma única linha utilizando a seguinte sintaxe:

```elixir
def enum_map_anon(list), do: Enum.map(list, fn elem -> elem + 1 end)
```
