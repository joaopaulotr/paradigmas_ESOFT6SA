## Derivação de um código a partir da gramática de Python

**1. Linguagem escolhida:** Python 3

**2. Fonte da gramática:** https://docs.python.org/3/reference/grammar.html — gramática oficial usada pelo parser do CPython, em notação **PEG** (Parsing Expression Grammar, uma mistura de EBNF com escolha ordenada).

**3. Regras de produção selecionadas** (extraídas e simplificadas da gramática real):

```
if_stmt         : 'if' named_expression ':' block
named_expression: comparison
comparison      : sum '>' sum
sum             : term
term            : factor
factor          : NAME | NUMBER
block           : simple_stmt
simple_stmt     : call
call            : NAME '(' arguments ')'
arguments       : expression
expression      : NAME
```

*Observação sobre a simplificação:* na gramática completa, `named_expression` se conecta a `comparison` através de uma cadeia de níveis intermediários (`expression → disjunction → conjunction → inversion → comparison`), cada um responsável por um operador diferente (`or`, `and`, `not`, etc.). Como o código escolhido não usa nenhum desses operadores, cada nível apenas repassa a regra para o próximo, então a cadeia foi colapsada em uma única seta para não tornar a derivação repetitiva sem ganho didático.

**4. Código a ser derivado:**
```python
if x > 0: print(x)
```

**5. Derivação passo a passo:**

```
if_stmt
⇒ 'if' named_expression ':' block
⇒ 'if' comparison ':' block
⇒ 'if' sum '>' sum ':' block
⇒ 'if' term '>' sum ':' block
⇒ 'if' factor '>' sum ':' block
⇒ 'if' NAME '>' sum ':' block
⇒ 'if' NAME '>' term ':' block
⇒ 'if' NAME '>' factor ':' block
⇒ 'if' NAME '>' NUMBER ':' block
⇒ 'if' NAME '>' NUMBER ':' simple_stmt
⇒ 'if' NAME '>' NUMBER ':' call
⇒ 'if' NAME '>' NUMBER ':' NAME '(' arguments ')'
⇒ 'if' NAME '>' NUMBER ':' NAME '(' expression ')'
⇒ 'if' NAME '>' NUMBER ':' NAME '(' NAME ')'
⇒ if x > 0 : print ( x )
```

**6. Terminais e não-terminais:**

- **Não-terminais:** `if_stmt`, `named_expression`, `comparison`, `sum`, `term`, `factor`, `block`, `simple_stmt`, `call`, `arguments`, `expression`
- **Terminais:** `'if'`, `':'`, `'>'`, `'('`, `')'`, `NAME`, `NUMBER`

`NAME` e `NUMBER` são terminais mesmo representando categorias (qualquer identificador/número) porque são tokens já resolvidos pelo analisador léxico do Python antes de chegar na gramática sintática, não são derivados por regras sintáticas.
