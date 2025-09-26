#!/bin/bash
# install.sh - Instalador do tsetup
#
# Este script instala o tsetup configurando automaticamente:
# - Adiciona o diretório atual ao PATH
# - Configura source automático no shell apropriado
# - Detecta macOS (.zshrc) vs Linux (.bashrc)
# - Verifica se já está instalado antes de duplicar

set -e  # Para na primeira falha

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funções de log
log_info() { printf "${BLUE}[INFO]${NC} %s\n" "$*"; }
log_success() { printf "${GREEN}[SUCCESS]${NC} %s\n" "$*"; }
log_warning() { printf "${YELLOW}[WARNING]${NC} %s\n" "$*"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$*"; }

# Detecta o sistema operacional
detect_os() {
    case "$(uname -s)" in
        Darwin*)
            echo "macos"
            ;;
        Linux*)
            echo "linux"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

# Determina o arquivo de configuração do shell baseado no OS
get_shell_config() {
    local os="$1"
    case "$os" in
        macos)
            echo "$HOME/.zshrc"
            ;;
        linux)
            echo "$HOME/.bashrc"
            ;;
        *)
            # Fallback: tenta detectar pelo shell atual
            if [[ -n "$ZSH_VERSION" ]]; then
                echo "$HOME/.zshrc"
            else
                echo "$HOME/.bashrc"
            fi
            ;;
    esac
}

# Verifica se uma linha já existe no arquivo
line_exists_in_file() {
    local file="$1"
    local line="$2"
    [[ -f "$file" ]] && grep -Fxq "$line" "$file"
}

# Adiciona linha ao arquivo se não existir
add_line_if_missing() {
    local file="$1"
    local line="$2"
    local description="$3"
    
    if line_exists_in_file "$file" "$line"; then
        log_warning "$description já existe em $file"
        return 0
    fi
    
    # Cria o arquivo se não existir
    if [[ ! -f "$file" ]]; then
        touch "$file"
        log_info "Criado arquivo $file"
    fi
    
    echo "$line" >> "$file"
    log_success "$description adicionado a $file"
}

# Função principal
main() {
    log_info "Instalando tsetup..."
    
    # Verifica se o arquivo tsetup existe
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local tsetup_path="$script_dir/tsetup"
    
    if [[ ! -f "$tsetup_path" ]]; then
        log_error "Arquivo tsetup não encontrado em $tsetup_path"
        exit 1
    fi
    
    # Torna o tsetup executável
    chmod +x "$tsetup_path"
    log_success "tsetup marcado como executável"
    
    # Detecta sistema operacional
    local os
    os=$(detect_os)
    log_info "Sistema detectado: $os"
    
    # Determina arquivo de configuração do shell
    local shell_config
    shell_config=$(get_shell_config "$os")
    log_info "Arquivo de configuração: $shell_config"
    
    # Adiciona duas linhas em branco para separação
    echo "" >> "$shell_config"
    echo "" >> "$shell_config"
    log_success "Duas linhas em branco adicionadas a $shell_config"
    
    # Adiciona comentário explicativo
    local comment="# tsetup - aliases por projeto"
    add_line_if_missing "$shell_config" "$comment" "Comentário do tsetup"
    
    # Adiciona diretório ao PATH
    local path_line="export PATH=\"$script_dir:\$PATH\""
    add_line_if_missing "$shell_config" "$path_line" "PATH do tsetup"
    
    # Adiciona source do tsetup
    local source_line="source tsetup"
    add_line_if_missing "$shell_config" "$source_line" "Source do tsetup"
    
    echo ""
    log_success "✅ Instalação concluída!"
    echo ""
    log_info "Para usar imediatamente, execute:"
    log_info "  source $shell_config"
    echo ""
    log_info "Ou abra um novo terminal."
    echo ""
    log_info "O tsetup agora está disponível globalmente."
    log_info "Navegue para qualquer projeto com arquivo .tsetup.json e os aliases serão carregados automaticamente."
    echo ""
    log_info "Crie um arquivo .tsetup.json no seu projeto para começar!"
}

# Executa se chamado diretamente (não sourçado)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
