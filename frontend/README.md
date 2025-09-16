# 🌟 Stellar Credit Frontend

Frontend do sistema Stellar Credit - Uma plataforma descentralizada de score de crédito baseada na rede Stellar.

## 🚀 Deploy & URLs

- **🌐 Produção**: https://stellar-credit-frontend.vercel.app
- **🔗 Repositório**: https://github.com/Jistriane/StellarCredit-1.0
- **📊 Backend API**: https://stellar-credit-backend.vercel.app
- **⚡ Deploy Automático**: Ativo via Vercel + GitHub

## 🛠️ Tecnologias

- **Framework**: Next.js 15.1.4 com App Router
- **Linguagem**: TypeScript
- **Styling**: Tailwind CSS + Headless UI
- **Blockchain**: Stellar SDK + Freighter Wallet
- **State Management**: Zustand
- **Autenticação**: WebAuthn (Passkeys)
- **Deploy**: Vercel com CI/CD automático

## 🌐 Ambiente Testnet

Este frontend está configurado para a **Stellar Testnet**:

```env
NEXT_PUBLIC_STELLAR_NETWORK=testnet
NEXT_PUBLIC_API_BASE_URL=https://stellar-credit-backend.vercel.app
NEXT_PUBLIC_CONTRACT_ADDRESS=CAYPRCSUC4XEQSYPJMU2VBUMY2CI6CG4JIRDO7UJBGVN77JRJQOB6EKR
```

- **🔗 Contrato**: [Ver no Stellar Expert](https://stellar.expert/explorer/testnet/contract/CAYPRCSUC4XEQSYPJMU2VBUMY2CI6CG4JIRDO7UJBGVN77JRJQOB6EKR)

## 🚀 Desenvolvimento Local

### Pré-requisitos
- Node.js 18+
- npm 8+

### Instalação e Execução

```bash
# Instalar dependências
npm ci

# Executar em desenvolvimento
npm run dev

# Build para produção
npm run build

# Executar produção localmente
npm start

# Linting e verificação de tipos
npm run lint
npm run type-check
```

Abra [http://localhost:3000](http://localhost:3000) no seu navegador.

## 🏗️ Estrutura do Projeto

```
src/
├── app/                    # App Router do Next.js
│   ├── [locale]/          # Páginas internacionalizadas
│   └── globals.css        # Estilos globais
├── components/            # Componentes React
│   ├── auth/             # Componentes de autenticação
│   ├── dashboard/        # Dashboard e score
│   ├── elisa/           # Assistente virtual Elisa
│   ├── passkey/         # Componentes de passkeys
│   ├── ui/              # Componentes de UI
│   └── wallet/          # Integração com wallets
├── hooks/                # Custom hooks
├── lib/                  # Utilitários e configurações
├── services/            # Serviços (WebAuthn, etc.)
├── stores/              # Estados globais (Zustand)
├── types/               # Definições TypeScript
└── messages/            # Arquivos de internacionalização
```

## 🔧 Features Principais

### 📊 Score de Crédito Descentralizado
- Análise de histórico na blockchain Stellar
- Score em tempo real baseado em transações
- Visualização de métricas e análises

### 🔐 Autenticação Multi-Wallet
- **Freighter**: Extensão principal da Stellar
- **Rabet**: Wallet móvel e web
- **Passkeys**: Autenticação biométrica WebAuthn

### 🤖 Assistente Virtual Elisa
- IA contextual para suporte ao usuário
- Análise de score e recomendações
- Suporte a voz e texto

### 📱 Interface Responsiva
- Design moderno com Tailwind CSS
- Compatível com mobile, tablet e desktop
- Modo escuro/claro

### 🌍 Internacionalização
- Suporte a português e inglês
- Rotas localizadas
- Conteúdo adaptado por região

## 🚀 Deploy Automático

O deploy é acionado automaticamente a cada push para `main` que modifique arquivos em `frontend/`:

1. **Build**: TypeScript compilation + Next.js build
2. **Deploy**: Deploy automático para Vercel
3. **Update**: URL de produção atualizada

### Configuração Vercel

```json
{
  "framework": "nextjs",
  "buildCommand": "npm run build",
  "outputDirectory": ".next",
  "installCommand": "npm ci"
}
```

## 🔐 Segurança

- **WebAuthn**: Autenticação biométrica nativa
- **Stellar SDK**: Integração segura com blockchain
- **Environment Variables**: Configurações sensíveis protegidas
- **TypeScript**: Type safety em tempo de compilação

## 🧪 Scripts Disponíveis

```bash
# Desenvolvimento
npm run dev              # Servidor de desenvolvimento
npm run build           # Build de produção
npm start              # Executar build localmente

# Qualidade de Código
npm run lint           # ESLint
npm run type-check     # TypeScript check
npm run test           # Jest (quando configurado)

# Análise
npm run analyze        # Bundle analyzer
```

## 🤝 Contribuição

1. Fork o repositório
2. Crie uma branch: `git checkout -b feature/nova-feature`
3. Commit: `git commit -m 'feat: adicionar nova feature'`
4. Push: `git push origin feature/nova-feature`
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 🆘 Suporte

- **Issues**: [GitHub Issues](https://github.com/Jistriane/StellarCredit-1.0/issues)
- **Documentação**: `/docs` no repositório principal
- **Discord**: [Stellar Developers](https://discord.gg/stellardev)

---

**Desenvolvido com ❤️ para a rede Stellar** 🌟
