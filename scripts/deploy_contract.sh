#!/bin/bash

# ========================================
# SCRIPT DE DEPLOY DO CONTRATO STELLAR CREDIT
# ========================================
# Este script automatiza o deploy do contrato na rede Stellar
# ========================================

set -e  # Para o script em caso de erro

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configurações
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONTRACTS_DIR="$PROJECT_ROOT/contracts"
LOG_DIR="$PROJECT_ROOT/logs"
mkdir -p "$LOG_DIR"

# Variáveis de ambiente (substitua pelos seus valores)
SECRET_KEY="SCVOS4PVPFBUXUL4MUAIOF2AOKXTAEHSWOMG2IIGI66TGCZASQR7SQDV"
PUBLIC_KEY="GCKZ35K7GMUJBFKBOS2YM7FUHATM5FHHFGH7AVNGC5TXLFGV265G33QX"
NETWORK="testnet"
LOG_FILE="$LOG_DIR/contract_deploy_$(date +"%Y%m%d_%H%M%S").log"

# Função para log
log() {
    echo -e "${2:-$NC}[$(date '+%Y-%m-%d %H:%M:%S')] $1${NC}" | tee -a "$LOG_FILE"
}

log_info() {
    log "$1" "$YELLOW"
}

log_success() {
    log "✅ $1" "$GREEN"
}

log_warning() {
    log "⚠️  $1" "$YELLOW"
}

log_error() {
    log "❌ $1" "$RED"
    exit 1
}

# Iniciar log
echo "" > "$LOG_FILE"
log_info "Iniciando deploy do contrato Stellar Credit..."
log_info "Rede: $NETWORK"
log_info "Conta: $PUBLIC_KEY"

# Verificar dependências
check_dependencies() {
    log_info "Verificando dependências..."
    
    if ! command -v soroban &> /dev/null; then
        log_error "Soroban CLI não encontrado. Instale em: https://soroban.stellar.org/docs/getting-started/install"
        exit 1
    fi
    
    if ! command -v cargo &> /dev/null; then
        log_error "Cargo não encontrado. Instale o Rust: https://www.rust-lang.org/tools/install"
        exit 1
    fi
    
    log_success "Dependências verificadas com sucesso"
}

# Compilar o contrato
build_contract() {
    log_info "Compilando contrato..."
    cd "$CONTRACTS_DIR"
    
    # Verificar se o diretório de destino existe
    if [ ! -d "$CONTRACTS_DIR/target" ]; then
        log_info "Criando diretório de build..."
        mkdir -p "$CONTRACTS_DIR/target"
    fi
    
    # Compilar em modo release
    log_info "Compilando em modo release..."
    cargo build --target wasm32-unknown-unknown --release 2>&1 | tee -a "$LOG_FILE"
    
    # Verificar se a compilação foi bem-sucedida
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        log_error "Falha na compilação do contrato"
        exit 1
    fi
    
    log_success "Contrato compilado com sucesso"
}

# Fazer deploy do contrato
deploy_contract() {
    log_info "Fazendo deploy do contrato na rede $NETWORK..."
    
    # Caminho para o contrato compilado
    WASM_PATH="$CONTRACTS_DIR/target/wasm32-unknown-unknown/release/stellar_credit_contract.wasm"
    
    # Verificar se o arquivo WASM existe
    if [ ! -f "$WASM_PATH" ]; then
        log_error "Arquivo WASM não encontrado em $WASM_PATH"
    fi
    
    # Configurar a rede
    log_info "Configurando rede $NETWORK..."
    soroban network add "$NETWORK" --rpc-url "https://soroban-testnet.stellar.org" --network-passphrase "Test SDF Network ; September 2015" 2>&1 | tee -a "$LOG_FILE"
    
    # Verificar se a rede foi configurada corretamente
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        log_warning "Rede $NETWORK já configurada ou erro na configuração. Continuando..."
    fi
    
    # Configurar a identidade
    log_info "Configurando identidade..."
    mkdir -p "$PROJECT_ROOT/.soroban"
    echo "$SECRET_KEY" > "$PROJECT_ROOT/.soroban/identity"
    chmod 600 "$PROJECT_ROOT/.soroban/identity"
    
    # Verificar saldo da conta
    log_info "Verificando saldo da conta..."
    BALANCE=$(soroban contract invoke \
        --network "$NETWORK" \
        --source "$SECRET_KEY" \
        --id "CDMT5XZWLG4PJ6B3D4KQ5JZ7Y6V4Z3XKJ2Y3XKJ2Y3XKJ2Y3XKJ2Y3" \
        -- \
        balance \
        --id "$PUBLIC_KEY" 2>&1 || true)
    
    log_info "Saldo da conta: $BALANCE"
    
    # Fazer o deploy
    log_info "Iniciando deploy..."
    CONTRACT_ID=$(soroban contract deploy \
        --wasm "$WASM_PATH" \
        --source "$SECRET_KEY" \
        --network "$NETWORK" 2>&1 | tee -a "$LOG_FILE" | tail -n 1)
    
    # Verificar se o deploy foi bem-sucedido
    if [[ -z "$CONTRACT_ID" || "$CONTRACT_ID" == *"error"* ]]; then
        log_error "Falha no deploy do contrato"
    fi
    
    log_success "Contrato implantado com sucesso!"
    log_info "Contract ID: $CONTRACT_ID"
    
    # Inicializar o contrato
    log_info "Inicializando contrato..."
    soroban contract invoke \
        --id "$CONTRACT_ID" \
        --source "$SECRET_KEY" \
        --network "$NETWORK" \
        -- \
        initialize \
        --admin "$PUBLIC_KEY" 2>&1 | tee -a "$LOG_FILE"
    
    # Verificar se a inicialização foi bem-sucedida
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        log_error "Falha ao inicializar o contrato"
    fi
    
    log_success "Contrato inicializado com sucesso!"
    
    # Salvar o ID do contrato em um arquivo
    echo "STELLAR_CREDIT_CONTRACT_ID=$CONTRACT_ID" > "$PROJECT_ROOT/.env.contract"
    
    log_info "Informações do contrato salvas em $PROJECT_ROOT/.env.contract"
}

# Função principal
main() {
    check_dependencies
    build_contract
    deploy_contract
    
    log_success "Deploy concluído com sucesso!"
    log_info "Logs detalhados disponíveis em: $LOG_FILE"
    log_info "ID do contrato salvo em: $PROJECT_ROOT/.env.contract"
}

# Executar função principal
main "$@"
