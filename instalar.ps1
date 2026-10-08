# Instala (ou atualiza) a skill do MetaBrain sem Node.js. Uso, no PowerShell:
#   irm https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/instalar.ps1 | iex
# Mesmas pastas do "npx skills add": ~/.claude/skills (Claude Code) e ~/.agents/skills (Codex, Antigravity e outros).
& {
    $ErrorActionPreference = "Stop"
    $base = "https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/skills/metabrain"
    $arquivos = "SKILL.md", "ferramentas.md", "conectar.md", "padroes-de-analise.md"
    $destinos = @(
        @{ Ferramenta = "Claude Code"; Existe = (Test-Path (Join-Path $HOME ".claude"));
           Pasta = Join-Path $HOME ".claude\skills\metabrain" },
        @{ Ferramenta = "Codex e Antigravity";
           Existe = (Test-Path (Join-Path $HOME ".codex")) -or (Test-Path (Join-Path $HOME ".gemini\antigravity"));
           Pasta = Join-Path $HOME ".agents\skills\metabrain" }
    )
    $instalados = 0
    foreach ($d in $destinos) {
        if (-not $d.Existe) { continue }
        New-Item -ItemType Directory -Force -Path $d.Pasta | Out-Null
        foreach ($a in $arquivos) {
            Invoke-WebRequest -UseBasicParsing -Uri "$base/$a" -OutFile (Join-Path $d.Pasta $a)
        }
        Write-Host "Skill do MetaBrain instalada para $($d.Ferramenta) em $($d.Pasta)"
        $instalados++
    }
    if ($instalados -eq 0) {
        Write-Host "Nenhuma ferramenta encontrada (Claude Code, Codex ou Antigravity). Instale uma e rode de novo."
    }
}
