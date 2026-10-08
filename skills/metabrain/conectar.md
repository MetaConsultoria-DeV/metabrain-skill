# Conectar o MetaBrain

O acesso é pessoal e vale 90 dias. A pessoa gera o acesso na página
https://sites-metabrain-app.d86ysa.easypanel.host/conectar (login com a conta Microsoft da Meta, a mesma do
SharePoint). A página mostra **uma frase para colar no chat** — começa com "Conecte o MetaBrain nesta ferramenta" e
traz a URL do servidor e o acesso (`mb_...`). Quando a pessoa colar essa frase aqui, **faça a configuração você
mesmo**, seguindo a seção da sua ferramenta. Não peça para ela mexer em terminal ou arquivo.

Regras:
- Nunca repita o acesso na resposta nem o grave em outro lugar além da configuração da ferramenta.
- Substitua um `metabrain` que já exista (acesso antigo); não crie duplicado.
- Depois de configurar, diga exatamente o próximo passo (abrir sessão nova / recarregar) e peça para a pessoa repetir
  a pergunta.
- Se não conseguir rodar comandos ou editar arquivos (permissão negada), mostre o comando ou o bloco da seção da
  ferramenta e diga onde colar.

## Claude Code

Rode (no Windows funciona igual no PowerShell e no Git Bash):

```bash
claude mcp remove metabrain --scope user
claude mcp add --transport http --scope user metabrain https://sites-metabrain-app.d86ysa.easypanel.host/mcp --header "Authorization: Bearer <SEU_TOKEN>"
```

O `remove` pode dizer que não existe — tudo bem. Se houver um `metabrain` antigo em outro escopo (`claude mcp get
metabrain` mostra o escopo), remova também (`claude mcp remove metabrain --scope local`). O escopo `user` faz o
MetaBrain valer em todas as pastas. Confira com `claude mcp get metabrain` (deve mostrar Connected) e diga à pessoa
para abrir uma sessão nova (`/exit` e `claude` de novo); `/mcp` deve listar `metabrain`.

## Codex

Edite `~/.codex/config.toml` (no Windows, `C:\Users\<usuário>\.codex\config.toml`; crie se não existir): apague a
tabela `[mcp_servers.metabrain]` antiga, se houver (até a próxima linha que começa com `[`), e acrescente no fim:

```toml
[mcp_servers.metabrain]
url = "https://sites-metabrain-app.d86ysa.easypanel.host/mcp"
http_headers = { "Authorization" = "Bearer <SEU_TOKEN>" }
```

Uma tabela duplicada quebra o arquivo. Confira com `codex mcp list` e diga à pessoa para abrir o Codex de novo.

## Antigravity

Edite `~/.gemini/config/mcp_config.json` (no Windows, `C:\Users\<usuário>\.gemini\config\mcp_config.json`; crie com
`{"mcpServers": {}}` se não existir). Se `~/.gemini/antigravity/mcp_config.json` também existir, faça o mesmo nele.
Dentro de `"mcpServers"`, sem apagar os outros servidores, ponha (ou substitua) a chave `metabrain`:

```json
"metabrain": {"serverUrl": "https://sites-metabrain-app.d86ysa.easypanel.host/mcp",
              "headers": {"Authorization": "Bearer <SEU_TOKEN>"}}
```

O JSON tem de continuar válido. Diga à pessoa para recarregar em **…** → **MCP Servers** → **Manage MCP Servers**
(ou reiniciar o Antigravity).

## Outras ferramentas

A página tem, em "Configurar manualmente", blocos prontos para Claude Desktop e Cursor.

## Acesso vencido

Se as chamadas começarem a falhar com 401 / não autorizado, o acesso venceu ou foi substituído (cada novo login na
página desativa o anterior). Também pode aparecer como "precisa de autenticação" / botão "Authenticate" no `/mcp`:
não use esse botão. Mande a pessoa entrar de novo na página e colar a frase nova aqui; refaça a configuração
substituindo a antiga.

## Instalar ou atualizar esta skill

`npx skills add MetaConsultoria-DeV/metabrain-skill -g` (precisa de Node.js). Sem Node, no PowerShell:
`irm https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/instalar.ps1 | iex`

O acesso identifica a pessoa em cada consulta: não deve ser compartilhado com outras pessoas.
