# Conectar o MetaBrain

O acesso é pessoal e vale 90 dias. Ele é gerado na página
https://sites-metabrain-app.d86ysa.easypanel.host/conectar — a pessoa entra com a conta Microsoft da Meta (a mesma
do SharePoint) e a página mostra o bloco pronto, já com o acesso, para cada ferramenta. Peça à pessoa para copiar o
bloco da página; nunca peça para ela colar o acesso na conversa.

## Claude Code

1. Copiar o comando do cartão "Claude Code" e colar no terminal.
2. Abrir uma sessão nova e conferir com `/mcp` que `metabrain` aparece conectado.

Formato (o real vem da página): `claude mcp add --transport http metabrain https://sites-metabrain-app.d86ysa.easypanel.host/mcp --header "Authorization: Bearer <SEU_TOKEN>"`

## Codex

1. Copiar o bloco do cartão "Codex" e colar no fim de `~/.codex/config.toml` (criar o arquivo se não existir; no
   Windows fica em `C:\Users\<você>\.codex\config.toml`).
2. Abrir o Codex de novo e conferir com `/mcp` (ou `codex mcp list`).

Formato:

```toml
[mcp_servers.metabrain]
url = "https://sites-metabrain-app.d86ysa.easypanel.host/mcp"
http_headers = { "Authorization" = "Bearer <SEU_TOKEN>" }
```

## Antigravity

1. No painel do agente: **…** → **MCP Servers** → **Manage MCP Servers** → **View raw config**.
2. Juntar o bloco do cartão "Antigravity" dentro de `"mcpServers"`, salvar e recarregar.

Formato:

```json
{"mcpServers": {"metabrain": {"serverUrl": "https://sites-metabrain-app.d86ysa.easypanel.host/mcp",
  "headers": {"Authorization": "Bearer <SEU_TOKEN>"}}}}
```

## Acesso vencido

Se as chamadas começarem a falhar com 401 / não autorizado, o acesso venceu ou foi substituído (cada novo login na
página desativa o anterior). Entrar de novo na página, copiar o bloco novo e substituir o antigo na ferramenta. Ele também pode aparecer como "precisa de autenticação" / botão "Authenticate" no `/mcp`, em vez de 401: não use esse
botão; gere um bloco novo na página /conectar e substitua o antigo.

## Instalar ou atualizar esta skill

`npx skills add MetaConsultoria-DeV/metabrain-skill -g` (precisa de Node.js). Sem Node, no PowerShell:
`irm https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/instalar.ps1 | iex`

Nunca compartilhe o acesso: ele identifica a pessoa em cada consulta.
