# Instala (ou atualiza) a skill do MetaBrain sem Node.js. Uso, no PowerShell:
#   irm https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/instalar.ps1 | iex
& {
    $ErrorActionPreference = "Stop"
    $base = "https://raw.githubusercontent.com/MetaConsultoria-DeV/metabrain-skill/main/skills/metabrain"
    $arquivos = "SKILL.md", "ferramentas.md", "conectar.md", "padroes-de-analise.md"
    $destinos = @(
        @{ Ferramenta = "Claude Code"; Raiz = Join-Path $HOME ".claude" },
        @{ Ferramenta = "Codex"; Raiz = Join-Path $HOME ".codex" },
        @{ Ferramenta = "Antigravity"; Raiz = Join-Path $HOME ".gemini\antigravity" }
    )
    $instalados = 0
    foreach ($d in $destinos) {
        if (-not (Test-Path $d.Raiz)) { continue }
        $pasta = Join-Path $d.Raiz "skills\metabrain"
        New-Item -ItemType Directory -Force -Path $pasta | Out-Null
        foreach ($a in $arquivos) {
            Invoke-WebRequest -UseBasicParsing -Uri "$base/$a" -OutFile (Join-Path $pasta $a)
        }
        Write-Host "Skill do MetaBrain instalada para $($d.Ferramenta) em $pasta"
        $instalados++
    }
    if ($instalados -eq 0) {
        Write-Host "Nenhuma ferramenta encontrada (Claude Code, Codex ou Antigravity). Instale uma e rode de novo."
    }
}
