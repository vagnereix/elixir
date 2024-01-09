# OTP

## O que é?

Um conjunto de bibliotecas e funções implementadas pelo `Erlang` que o `Elixir` utiliza.

## Processos

- Processos são criados utilizando a função `spawn`;
- Tipicamente desenvolvedores não utilizam essa função diretamente, ao invés disso utilizam abstrações como `Task`, `GenServer` e `Agent`, mas no fundo a função `spawn` é utilizada para gerar processos;
- Processos são encarregados de executar uma operação e após a mesma o `Elixir` finalizará o mesmo;
- Cada processo é isolado, cada um com sua responsabilidade porém podendo haver comunicação entre os mesmos;
- Basicamente tudo dentro do `Elixir` é um processo.

### Exemplos

```elixir
defmodule Processes do
  def query(n) do
    1..n
    |> Enum.map(&spawn(fn -> execute(&1) end))
  end

  defp execute(q) do
    :timer.sleep(2000)
    IO.puts("Query #{q} executed")
  end
end

iex> Processes.query(10)
# [#PID<0.206.0>, #PID<0.207.0>, #PID<0.208.0>, #PID<0.209.0>, ...]
# Query 1 executed
# Query 2 executed
# Query 3 executed
# ...
```

No dia a dia a função `spawn` não é utilizada diretamente como no exemplo acima, o mesmo serve apenas para entender o funcionamento da mesma.

## Send & Receive

As funções `send` e `receive` como os próprios nomes nos dizem, repectivamente enviam e recebem uma informação enviada para um processo.

```elixir
def receive_calc() do
  receive do
    {:mult, first_value, second_value} -> IO.puts(first_value * second_value)
  end
end

iex> pid = spawn(Processes, :receive_calc, [])
iex> send pid, {:mult, 2, 4}
# 8
# {:mult, 2, 4}
```
