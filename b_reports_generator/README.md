# Ignite Elixir - Módulo 02

## Pipe Operator

O pipe operador pega tudo o que vem antes dele e passa de forma implícita para a próxima função.

```elixir
iex> "@VagNereiX" |> String.downcase() # @vagnereix
```

## Range

O range e utilizado quando precisamos executar uma ação x vezes, de um valor até outro.

```elixir
iex> Enum.concat([1..5]) # [1, 2, 3, 4, 5]
```

## Função anônima - short hand

A forma mais curta de criar uma função anônima ou passar paràmetros para uma função já existente é utilizando o operador `&` antes da mesma.
O exemplo abaixo une o Range visto acima com a short hand funtion.

```elixir
iex> Enum.map(1..3, &Integer.to_string(&1)) # ["1", "2", "3"]
```

No exemplo acima passamos o primeiro parâmetro através do `&1`, sendo esse o elemento que a função `map` retorna a cada ciclo (já que um map retorna apenas um elemento por vez), o mesmo acontece quando passamos utilizando a sintaxe `/1`.

```elixir
iex> Enum.map(1..3, &Integer.to_string/1) # ["1", "2", "3"]
```

Caso a função anterior (nesse exemplo o `map`) retornasse mais de um elemento, poderíamos passar os mesmo através da mesma sintaxe alterando apenas o número do parâmetro como `&2, &3, &4`. Veremos o funcionamento do exemplo de uso da função `reduce` logo abaixo.

## Enum

### Reduce

O `Enum.reduce` recebe uma coleção para percorrer, um acumulador inicial (que pode ser de qualquer tipo, nesse caso será um `map`) e uma função que recebe um item da `coleção` como primeiro parâmetro e o `acumulador atual` como segundo a cada iteração.

```elixir
iex> Enum.reduce([:vagnereix], %{}, &Map.put(&2, &1, "Front-end specialist"))
# %{vagnereix: "Front-end specialist"}
```

### Into

O `Enum.into` basicamente insere um `enumerable` em um `collectable`, o mesmo recebe o enumerable que no exemplo abaixo será um `range`, o collectable onde cada item do range enviado como parâmetro será adicionado e a forma de como esse item será adicionado à coleção de destino. No exemplo abaixo criamos uma chave com valor 0 dentro de um mapa para cada enumerable.

```elixir
iex> Enum.into(1..3, %{}, &{Integer.to_string(&1), 0})
# %{"1" => 0, "2" => 0, "3" => 0}
```

### Max_by

O `Enum.max_by` recebe uma coleção como primeiro parâmetro e o elemento dessa coleção que deverá ser comparado para retornar o maior valor entre eles.

```elixir
iex> Enum.max_by(%{"1" => 0, "2" => 10}, fn {_, value} -> value end) # %{"2", 10}
iex> Enum.max_by(%{"1" => 0, "2" => 10}, & &1) # %{"2", 10}
```

## Variáveis de módulo

Uma variável de módulo pode ser definida utilizando o `@` antes do nome da mesma.
Esse tipo de variável pode ser utilizada globalmente dentro de um mesmo módulo, em qualquer uma de suas funções.

```elixir
# example.ex
defmodule Example do
  @options ["foods", "users"]

  def run, do: Enum.into(@options, %{}, &{&1, 0})
end

iex> Example.run # %{"foods" => 0, "users" => 0}
```

## Guards

São utilizados para dar mais poder ao `pattern matching` inferindo condições ao mesmo por meio da palavra reservada `when`.
Pode ser utilizado para todas as funções do tipo `is_` e para todos os operadores lógicos.

```elixir
# example.ex
defmodule Example do
  @options ["foods"]

  def run(option) when option in @options do
    {:ok, option}
  end
  defp run(_, _), do: {:error, "Invalid option"}
end

iex> Example.run("foods") # {:ok, "foods"}
iex> Example.run("users") # {:error, "Invalid option"}
```
