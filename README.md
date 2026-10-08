# Skill do MetaBrain

Skill para Claude Code, Codex e Antigravity pesquisarem o acervo histórico da Meta Consultoria pelo MCP do
MetaBrain, com método de análise e citação de fontes.

## 1. Conecte o MetaBrain

Entre em https://sites-metabrain-app.d86ysa.easypanel.host/conectar com a sua conta Microsoft da Meta e siga o
cartão da ferramenta que você usa.

## 2. Instale a skill

```bash
npx skills add MetaConsultoria-DeV/metabrain-skill -g
```

Sem Node.js (Windows, PowerShell):

```powershell
irm https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/instalar.ps1 | iex
```

Rode o mesmo comando para atualizar.

## 3. Teste

Pergunte na sua ferramenta: "Pelo MetaBrain, que projetos de mapeamento de processos a Meta já fez e como o preço
deles mudou ao longo dos anos?"
