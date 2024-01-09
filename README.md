# Ignite **Elixir** - Rocketseat

## Listas

- As listas no `Elixir` são do tipo `Lista Encadeada`;
- Utilizadas quando temos um volume muito grande de dados.
  - Coleção de informações vindas de uma API que serão iteradas posteriormente;
  - Tamanho e tempo de execução linear.

### Exemplo de métodos em listas

- `hd(list)`: retorna o primeiro elemento ou o elemento `HEAD` da lista encadeada;
  ```elixir
  hd([1,2,3]) # 1
  ```
- `tl(list)`: retorna o restante ou a `CALDA` da lista encadeada.
  ```elixir
  tl([1,2,3]) # [2,3]
  ```

## Tuplas

- No geral, utilizadas em retorno de funções;
- Na maioria das vezes utilizadas sempre com dois elementos.
  - `{:error, :enoent}`;
  - `{:ok, content}`.s

### Exemplo de métodos em tuplas

- `elem(tup_name, elem_position)`: acessa um elemento de uma determinada posição dentro da tupla;
  ```elixir
  x = {1,2,3}
  elem(x, 0) # 1
  ```
- `put_elem(tup_name, elem_position, new_value)`: altera o valor de um elemento de uma determinada posição dentro da tupla.
  ```elixir
  x = {1,2,3}
  put_elem(x, 1, "vagnereix") # {1,"vagnereix",3}
  ```

## Mapas

- Criamos mapas através de `${}`;
- Podemos criar um mapa utilizando `strings` através de `arrows` ou `atoms` através de dois pontos.
  - Quando criamos utilizando `strings` nós `NÃO` conseguimos acessar diretamente elementos do mapa utilizando `map.a` por exemplo, somente através de colchetes utilizando a notação `map["a"]`;
    ```elixir
    x = %{"a" => 1, "b" => 2}
    x["a"] # 1
    x.a # ** (KeyError) key :a not found in: %{"a" => 1, "b" => 2}
    ```
  - Quando utilizando através de `atoms` podemos acessar os elementos do mapa através de `map.a` e `map.b` por exemplo, e também através de `map[:a]` e `map[:b]`.
    ```elixir
    x = %{a: 1, b: 2}
    x[:a] # 1
    x.a # 1
    x["a"] # nil
    ```

## Pattern Matching

No `Elixir` o operador igual [ `=` ] é um operador de `Match`.
Quando fazemos uma operação do tipo `x = 4` nós `NÃO` estamos atribuindo 4 ao valor de x, e sim tentando encontrar um valor de x `que torne a expressão verdadeira`, nesse caso para a expressão `x = 4` ser verdade, `x precisará ser 4`.

Exemplo:

```elixir
x = 4 # 4
4 = x # 4
5 = x # ** (MatchError) no match of right hand side value: 4
```

Na última linha recebemos uma excessão como retorno pois 5 não equivale a 4, logo a expressão não deu `Match`.

- Uma atribuição só pode acontecer do lado esquerdo da expressão;
  ```elixir
  x = 1 # 1
  2 = x # ** (MatchError) no match of right hand side value: 1
  ```
- Exemplo de Pattern Matching com `Listas`;
  ```elixir
  x = [1,2,3]
  [y | z] = x
  y # 1
  z # [2,3]
  ```
- Exemplo de Pattern Matching com `Mapas`;
  ```elixir
  x = %{a: 1, b: 2, c: 3}
  %{c: valor} = x
  valor # 3
  ```
- Exemplo de Pattern Matching com `Tuplas`.
  ```elixir
  x = {:ok, 24}
  {:ok, result} = x
  result # 24
  ```

## Pin operator

Podemos fixar o valor de uma variável para verificarmos se a mesma já foi atribuído anteriormente. Para isso basta utilizarmos o operador [ `^` ] antes do nome da variável que queremos `pinnar`.

```elixir
x = 1 # 1
^x = 1 # 1
^x = 2 # ** (MatchError) no match of right hand side value: 2
```

## Funções

- Podemos criar e executar uma função anônima utilizando a seguinte sintaxe;
  ```elixir
  mult_func = fn (a, b) -> a * b end
  mult_func.(3,5) # 15
  ```
- Podemos também definir funções anônimas que recebem tuplas e se comportam de acordo com o conteúdo dessas tuplas, resultando em uma espécie de `if and else`;

  ```elixir
  read_file = fn
    {:ok, file_name} -> "Success to find the file: #{file_name}"
    {:error, reason} -> "Error to find the file: #{reason}"
  end

  read_file(File.read("existing_file.txt")) # "Success to find the file: Hi, I'm here."
  read_file(File.read("unexisting_file.txt")) # "Error to find the file: enoent."
  ```

- Toda função que termina com interrogação retorna um `booleano`.
  ```elixir
  Enum.any?([1,2,3], fn elem -> elem > 1 end) # true
  Enum.all?([1,2,3], fn elem -> elem > 1 end) # false
  ```

## Testes no Elixir

- Sempre testamos as funções públicas;
- Sempre especificamos a `aridade` da função que estamos testando.
  ```elixir
  describe "call/1" do
    test "sum a empty list", do: assert ASumList.call([]) == 0
  end
  ```
