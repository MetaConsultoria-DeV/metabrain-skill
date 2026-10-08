# Skill do MetaBrain

Skill para Claude Code, Codex e Antigravity pesquisarem o acervo histórico da Meta Consultoria pelo MCP do
MetaBrain, com método de análise e citação de fontes.

## 1. Instale a skill

```bash
npx skills add MetaConsultoria-DeV/metabrain-skill -g
```

Sem Node.js (Windows, PowerShell):

```powershell
irm https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/instalar.ps1 | iex
```

Rode o mesmo comando para atualizar.

## 2. Pergunte

Pergunte na sua ferramenta: "Pelo MetaBrain, que projetos de mapeamento de processos a Meta já fez e como o preço
deles mudou ao longo dos anos?"

Na primeira vez a IA vai pedir para você entrar em https://sites-metabrain-app.d86ysa.easypanel.host/conectar com a
sua conta Microsoft da Meta e colar no chat a frase que a página mostra. A própria IA faz a configuração; depois é
só abrir uma sessão nova e repetir a pergunta.
