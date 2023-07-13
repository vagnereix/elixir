# Ignite Elixir - Rocketseat

## Brincando com Mapas

- Podemos atualizar chaves de um Map utilizando a função Map.merge, caso uma chave ainda não exista, a mesma será adicionada ao mapa, caso contrário, a chave será atualizada.

  ```elixir
  iex> mapa = %{name: "Default Name", age: 18} # %{name: "Default Name", age: 18}
  iex> mapa = Map.merge(mapa, %{name: "Vag", email: "vagnereix.dev@gmail.com"})
  # %{name: "Vag", age: 18, email: "vagnereix.dev@gmail.com"}
  ```

- Caso queiramos fazer algo com o antigo valor de uma chave existente no mapa ao atualizá-lo, podemos utilizar a função Map.update.

  - A mesma recebe um mapa, uma chave, um valor padrão e uma função de transformação, essa função recebe o valor atual da chave como parâmetro caso ela já exista e o valor resultante da mesma é atribuído à chave no novo mapa retornado.

    ```elixir
    iex> mapa = %{a: 1, b: 2} # %{a: 1, b: 2}
    iex> mapa = Map.update(mapa, :a, "default_value", fn value -> value + 1 end) # %{a: 2, b: 2}
    ```

  - Caso a chave ainda não existe, a mesma é criada e o valor padrão é inserido no novo mapa.

    ```elixir
    iex> mapa = Map.update(mapa, :c, "default_value", fn value -> value + 1 end) # %{a: 2, b: 2, c: "default_value"}
    ```

- Uma outra forma de utilizar o Map.update é através da sintaxe de atualização de mapas `(%{})` combinada com o pipe operator `|`.

  ```elixir
  iex> mapa = %{a: 1, b: 2} # %{a: 1, b: 2}
  iex> mapa = %{mapa | b: 3, c: 4} # %{a: 1, b: 3, c: 4}
  ```

## Agent API

Essa APi funciona quase que como um localStorage dos navegadores, onde podemos guardar um determinado estado da nossa aplicação e manipulá-lo através dos métodos update, get e start.

Assim como processos no Elixir um Agent fica "vivo" até que seja encerrado pela aplicação.

```elixir
iex> {:ok, agent} = Agent.start_link fn -> %{} end # {:ok, #PID<0.201.0>
iex> Process.alive?(agent) # true
iex> Agent.update(agent, &Map.put(&1, :owner, "vagnereix")) # :ok
iex> Agent.get(agent, & &1) # %{owner: "vagnereix"}
```
