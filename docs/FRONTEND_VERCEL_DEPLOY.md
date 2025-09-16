# Deploy Automático do Frontend (Vercel)

Este guia configura o deploy contínuo do frontend (`frontend/`) na Vercel, apontado para a rede `testnet` da Stellar.

## Pré-requisitos

- Repositório no GitHub com branch `main` ou `master`.
- Conta na Vercel (gratuita ou paga).
- Acesso ao projeto na Vercel (Org/Team e Project ID).

## Passo 1 — Criar o projeto na Vercel

1. Faça login na Vercel e clique em "New Project".
2. Importe o repositório do GitHub.
3. Selecione o diretório `frontend/` como a raiz do projeto (Project Settings > Root Directory = `frontend`).
4. Framework: Next.js (auto-detectado).
5. Configure variáveis de ambiente (pode ser agora ou depois):
   - `NEXT_PUBLIC_STELLAR_NETWORK = testnet`
   - `NEXT_PUBLIC_API_BASE_URL = https://SEU_BACKEND_URL` (ex: https://api.seu-dominio.com)
   - `NEXT_PUBLIC_CONTRACT_ADDRESS = CAYPRCSUC4X...` (igual ao valor de `.env.contract` > `STELLAR_CREDIT_CONTRACT_ID`)
6. Faça um primeiro deploy manual para validar.

Observação: Você pode usar o arquivo `frontend/vercel.json` já incluso para padronizar comandos de build (`npm ci`, `npm run build`).

## Passo 2 — Criar um Token de Acesso da Vercel

1. Em https://vercel.com/account/tokens, crie um **Access Token**.
2. Guarde o valor; será usado como `VERCEL_TOKEN` no GitHub Secrets.

## Passo 3 — Obter Org ID e Project ID

- No dashboard do seu projeto Vercel, acesse:
  - Project Settings > General
  - Copie `Project ID` (ex: `prj_xxx...`).
  - Para `Org ID` (ou `Team ID`), acesse as configurações da organização/time (ex: `team_xxx...`).

## Passo 4 — Configurar GitHub Secrets

No repositório (Settings > Secrets and variables > Actions > New repository secret):

- `VERCEL_TOKEN` — token criado no Passo 2
- `VERCEL_ORG_ID` — ID da sua organização/time na Vercel
- `VERCEL_PROJECT_ID` — ID do projeto Vercel do frontend
- `NEXT_PUBLIC_API_BASE_URL` — URL pública do seu backend (ex: `https://api.seu-dominio.com`)
- `NEXT_PUBLIC_CONTRACT_ADDRESS` — Contract ID atual (pode ser lido de `.env.contract`)

## Passo 5 — Workflow do GitHub Actions

O repositório já inclui o workflow:

- Arquivo: `.github/workflows/deploy-frontend-vercel.yml`
- Dispara em `push` para `main`/`master` dentro de `frontend/**`.
- Executa:
  - `npm ci`
  - `npm run build`
  - Deploy via `amondnet/vercel-action@v25`
- Usa os secrets configurados acima.

Se quiser disparar manualmente:
- Vá em GitHub > Actions > "Deploy Frontend to Vercel" > "Run workflow".

## Passo 6 — Variáveis de Ambiente

Você tem duas opções:

1) Definir variáveis na Vercel (recomendado):
- `NEXT_PUBLIC_STELLAR_NETWORK = testnet`
- `NEXT_PUBLIC_API_BASE_URL` — URL do backend (produção)
- `NEXT_PUBLIC_CONTRACT_ADDRESS` — ID do contrato em produção/testnet

2) Deixar o workflow injetar durante o build:
- Já configurado no step `Build` do workflow para usar seus Secrets de GitHub.

## Passo 7 — Verificações Importantes

- O frontend usa `NEXT_PUBLIC_*` para acessar as variáveis em runtime do browser. Verifique onde são consumidas.
- Se preferir não expor `NEXT_PUBLIC_CONTRACT_ADDRESS`, pode buscar via backend (ex.: endpoint `/api/stats` retorna `contract_address`).
- Garanta CORS e URLs corretas no backend (`FRONTEND_URL`).

## Rollback e Ambientes

- Na Vercel, você pode promover/deploy uma preview como produção facilmente.
- Considere usar branches para ambientes (ex.: `develop` -> Preview, `main` -> Production).

## Troubleshooting

- Erro de build na Vercel: verifique a versão do Node (Vercel usa 18/20), dependências e env vars.
- 404 após deploy: confira se o root directory está configurado como `frontend/` na Vercel.
- Variável vazia no runtime: lembre-se que `NEXT_PUBLIC_*` precisa estar definido no momento do build.

## Referências

- Vercel Action: https://github.com/marketplace/actions/vercel-action
- Next.js na Vercel: https://vercel.com/docs/frameworks/nextjs
