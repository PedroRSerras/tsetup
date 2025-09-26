# tsetup - Terminal Setup por Projeto

Sistema simples para criar aliases e executar comandos de setup específicos por projeto.

## Funcionalidades

- ✅ **Aliases por projeto**: Crie aliases específicos que não conflitam entre projetos
- ✅ **Comandos de setup**: Execute comandos automaticamente ao carregar a configuração  
- ✅ **Busca automática**: Encontra configuração na raiz, `.vscode`, `.cursor`, `.venv`
- ✅ **Compatibilidade**: Funciona com bash e zsh, versões antigas e novas
- ✅ **Instalação simples**: Script de instalação automática

## Instalação

### Instalação Automática (Recomendada)

```bash
# Clone o repositório
git clone <link_do_repositório>
cd tsetup

# Execute o instalador
./install.sh
```

O instalador vai:
- Adicionar o diretório do tsetup ao seu PATH
- Configurar o carregamento automático no seu shell (`.zshrc` ou `.bashrc`)
- Tornar o script executável

Após a instalação, reinicie o terminal ou execute:
```bash
source ~/.zshrc  # ou ~/.bashrc no Linux
```

### Instalação Manual

1. Copie o arquivo `tsetup` para um local no seu PATH
2. Torne-o executável: `chmod +x tsetup`
3. Adicione ao seu `.zshrc` ou `.bashrc`:
   ```bash
   # tsetup - aliases por projeto
   export PATH="/caminho/para/tsetupper:$PATH"
   source tsetup
   ```

## Uso Básico

Após a instalação, o `tsetup` funciona automaticamente:

1. **Navegue para qualquer projeto** que tenha um arquivo `.tsetup.json`
2. **Os aliases são carregados automaticamente** quando você abre um terminal em um diretório com .tsetup.json
3. **Use os aliases** definidos na configuração do projeto

### Comandos Manuais (Opcionais)

```bash
# Carregar configuração manualmente (se necessário)
source tsetup

# Ver os comandos
source tsetup -s
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

Aviso: 100% feito com IA ;-;
