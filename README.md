# tsetup - Terminal Setup por Projeto

Sistema simples para criar aliases e executar comandos de setup específicos por projeto.

## Funcionalidades

- ✅ **Aliases por projeto**: Crie aliases específicos que não conflitam entre projetos
- ✅ **Comandos de setup**: Execute comandos automaticamente ao carregar a configuração  
- ✅ **Busca automática**: Encontra configuração na raiz, `.vscode`, `.cursor`, `.venv`
- ✅ **Compatibilidade**: Funciona com bash e zsh, versões antigas e novas
- ✅ **Limpeza fácil**: Remove aliases carregados quando necessário

## Instalação

1. Copie o arquivo `tsetup` para um local no seu PATH
2. Torne-o executável: `chmod +x tsetup`

## Uso Básico

```bash
# Carregar configuração do projeto atual
source tsetup

# Ver o que seria executado (modo dry-run)
source tsetup --print

# Limpar aliases carregados anteriormente
source tsetup --clear
```

## Configuração

Crie um arquivo `.tsetup.json` na raiz do seu projeto:

```json
{
  "setup-commands": [
    "echo Terminal configurado para desenvolvimento",
    "export PROJECT_ROOT=$(pwd)"
  ],
  "alias": {
    "b": "ninja -C build/",
    "cb": "cmake -G Ninja -B build/",
    "clean": "rm -rf build/",
    "rmold": ""
  }
}
```

### Campos da Configuração

- **`setup-commands`**: Array de comandos shell executados antes de criar os aliases
- **`alias`**: Objeto com pares nome/comando para criar aliases
  - String vazia (`""`) remove um alias existente
  - Comandos são automaticamente escapados para uso seguro

## Locais de Busca

O `tsetup` procura configuração nos seguintes locais (em ordem):

1. `.tsetup.json` ou `.tsetup` na raiz do projeto
2. `.vscode/.tsetup.json` ou `.vscode/.tsetup`  
3. `.cursor/.tsetup.json` ou `.cursor/.tsetup`
4. `.venv/.tsetup.json` ou `.venv/.tsetup`

A busca sobe diretórios automaticamente até encontrar uma configuração.

## Variáveis de Ambiente

- `TSETUP_CONFIG`: Força uso de arquivo específico
- `TSETUP_PROGRAM`: Muda prefixo do arquivo (padrão: `tsetup`)

## Vantagens

- **Isolamento**: Aliases ficam específicos por projeto
- **Simplicidade**: Um arquivo JSON simples
- **Flexibilidade**: Comandos de setup + aliases
- **Portabilidade**: Funciona em diferentes shells e versões
- **Limpeza**: Remove aliases quando não precisar mais

## Dependências

- `bash` ou `zsh`
- `jq` (recomendado, mas funciona sem ele usando Python como fallback)
