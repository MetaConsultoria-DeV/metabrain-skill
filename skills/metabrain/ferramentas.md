# Ferramentas do MetaBrain

Os resultados vêm em JSON com um campo `status`. Erros de validação de parâmetros voltam como erro da ferramenta,
sem `status`: corrija o parâmetro e repita. As respostas são limitadas a ~16 KB: `trecho`/`texto` longos são
encurtados primeiro e depois itens são descartados, com a contagem em `omitidos`; leia o documento inteiro com
`ler_documento` antes de se apoiar num trecho.

## buscar_documentos

Busca trechos que respondem a uma pergunta (por significado e por palavras).

- `pergunta` (obrigatória, 3–1000 caracteres): em português, com as palavras da pessoa.
- Filtros opcionais: `projeto` (código como N2199 ou parte do nome), `ano_de`, `ano_ate`, `tipo`, `area`,
  `servico` (valores em `listar_opcoes`), `origem` (`documento`, `transcricao` ou `planilha`).
- `k`: quantos trechos (1–20, padrão 8).
- Cada item traz `trecho`, `item_id`, `nome`, `projeto`, `ano`, `tipo`, `link`, `citacao` e `similaridade` (0–1;
  quanto maior, mais parecido com a pergunta; ausente quando o `modo` da resposta é `bm25`, a busca só por palavras
  usada se a semântica estiver indisponível — a resposta traz um `aviso`, e isso não é erro). Transcrições trazem `minuto`.
- Se nenhum trecho for parecido o bastante, devolve `evidencia_insuficiente` em vez de resultados fracos.

## ler_documento

Lê o texto integral de um documento, em páginas de até 8.000 caracteres.

- `item_id` (obrigatório): de um resultado de `buscar_documentos` ou de `contar_documentos` (com `listar` > 0).
- `inicio`: posição onde começar; para a próxima página use o `proximo_inicio` devolvido (`null` = acabou).
- Traz `total_caracteres`, `link` e `citacao`. Planilhas vêm com todas as linhas quando disponíveis; senão há um
  `aviso` de que só parte das linhas está no texto.

## contar_documentos

Conta (exato) e opcionalmente agrupa e lista documentos. Use para "quantos", "quais", "em que anos", listas e
comparações — nunca conte a partir de `buscar_documentos`.

- `agrupar_por`: `ano`, `tipo`, `area`, `servico`, `origem` ou `projeto`.
- `listar`: quantos documentos listar (0–50; 0 = só contar); só com `listar` > 0 vêm documentos com `item_id`.
- Filtra apenas por `projeto`, `ano_de`/`ano_ate`, `tipo`, `area`, `servico` e `origem`. **Não tem busca por texto
  nem por tema**: mapeie o tema para `servico`/`area`/`tipo` com `listar_opcoes`; sem isso, meça a presença do
  tema com `buscar_documentos` por período. Nunca apresente a contagem do acervo inteiro como contagem do tema.

## consultar_precos

Preços que a Meta cobrou em projetos fechados (PPPs finais, 2011–2023): mínimo, quartis, mediana e máximo, com
exemplos e links.

- Filtros: `servico` (valores em `listar_opcoes` campo `servico_preco`), `porte` (campo `porte`), `ano_de`, `ano_ate`.
- Sempre repita o `aviso`: valores históricos e nominais, sem correção pela inflação. Com poucos casos vem
  `aviso_amostra`.

## listar_opcoes

Valores válidos para os filtros. Use antes de filtrar quando não souber o valor exato.

- `campo`: `tipo`, `area`, `servico`, `origem`, `servico_preco`, `porte` ou `projeto`.
- `contendo`: parte do valor procurado (ex.: parte do nome de um projeto).

## registrar_feedback

Registra se a resposta ajudou. Vira teste da busca e melhora o MetaBrain.

- `pergunta` e `ajudou` (obrigatórios); `item_ids` citados (até 20); `item_certo` se a pessoa souber qual era o
  documento certo; `comentario`.

## Status

| status | o que fazer |
|---|---|
| `ok` | use o resultado. |
| `evidencia_insuficiente` | o MetaBrain não achou trecho que responda com segurança. Diga isso; tente outras palavras ou menos filtros; não complete com conhecimento geral. |
| `ambiguo` | um filtro bateu com vários valores; escolha entre os candidatos devolvidos e repita. |
| `nao_encontrado` | o valor do filtro ou o `item_id` não existe; confira em `listar_opcoes` ou use um `item_id` devolvido por outra ferramenta. Não conclua que o assunto não existe. |
| `sem_dados` | não há preços com esses filtros; afrouxe os filtros. |
| `entrada_invalida` | parâmetro fora do permitido (ex.: `ano_de` maior que `ano_ate`, `inicio` além do fim); corrija e repita. |
| `limite` | muitas chamadas em pouco tempo: até 30 chamadas em rajada, depois ~1 a cada 2 s. Espere ~60 s e continue de onde parou. |
| `erro_interno` | falha temporária; tente de novo em instantes. Se persistir, avise a pessoa. |
