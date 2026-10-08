# Padrões de análise

Sequências de chamadas para análises comuns. Combine os padrões quando a pergunta pedir; ajuste filtros ao que
`listar_opcoes` devolver. Lembre do limite (até 30 chamadas em rajada) e planeje.

## Evolução ao longo do tempo

Ex.: "como a Meta passou a fazer mapeamento de processos ao longo dos anos?"

1. `contar_documentos` não busca por texto: mapeie o tema para `servico`/`area`/`tipo` via `listar_opcoes` e use
   `agrupar_por: "ano"` com esse filtro — onde há material. Sem filtro que represente o tema, a contagem é do acervo
   inteiro e não pode ser apresentada como contagem do tema; meça a presença com `buscar_documentos` por período.
2. Escolha 3–5 períodos com material e rode `buscar_documentos` em cada um (`ano_de`/`ano_ate`).
3. `ler_documento` nos 1–2 documentos mais fortes de cada período.
4. Monte uma linha do tempo: o que mudou, quando, e a evidência de cada mudança.

## Comparação entre projetos parecidos

Ex.: "que projetos parecidos com este já fizemos e o que deu certo?"

1. `listar_opcoes` (`servico`, `area`) para achar os valores do tema.
2. `contar_documentos` com `agrupar_por: "projeto"` e `listar` para ver os projetos candidatos.
3. Para cada projeto escolhido: `buscar_documentos` com `projeto` (escopo, entregáveis, resultado, problemas).
4. `ler_documento` em propostas e relatórios finais.
5. Tabela comparativa: projeto | ano | escopo | preço | resultado | citação.

## Referência de preço

Ex.: "quanto cobrar por um projeto de X para empresa de porte Y?"

1. `listar_opcoes` com `campo: "servico_preco"` e `campo: "porte"`.
2. `consultar_precos` com o serviço e o porte; depois sem o porte e depois por períodos, para ver a variação.
3. `buscar_documentos` por propostas do serviço para entender o que entrava no escopo daqueles preços.
4. Entregue faixa (quartis e mediana), exemplos citados e o aviso de valores históricos nominais.

## Histórico de cliente ou setor

Ex.: "já atendemos o varejo? o que fizemos?"

1. `listar_opcoes` com `campo: "projeto"` e `contendo` com o nome do cliente — o projeto pode ter outro nome.
2. `buscar_documentos` pelo nome do cliente e pelo setor, sem filtro de projeto, para achar menções.
3. `contar_documentos` com `projeto` para o tamanho do material de cada projeto achado.
4. `ler_documento` em proposta e relatório final de cada projeto.

## Mapa de lacunas

Use quando a pergunta depender de algo que pode não estar no acervo.

1. `contar_documentos` agrupando por `ano` e por `tipo`, só com filtros que existem (projeto, anos, `tipo`, `area`,
   `servico`, `origem`; sem busca por tema). Para um tema sem filtro próprio, use `buscar_documentos` por período.
2. Aponte anos ou tipos sem documentos e diga que a ausência pode ser do acervo, não da história da Meta.
3. Sugira o que a pessoa pode procurar fora do MetaBrain (ex.: o SharePoint direto, ex-membros da época).
