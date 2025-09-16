# Stellar Credit — Deployments History

Este arquivo documenta o histórico de deploys do smart contract do projeto Stellar Credit.

## Último Deploy

- Data/Hora: 2025-09-16 04:49:37
- Rede: testnet
- Conta (Public Key): GCKZ35K7GMUJBFKBOS2YM7FUHATM5FHHFGH7AVNGC5TXLFGV265G33QX
- Contract ID: CAYPRCSUC4XEQSYPJMU2VBUMY2CI6CG4JIRDO7UJBGVN77JRJQOB6EKR
- Explorer (Contrato): https://stellar.expert/explorer/testnet/contract/CAYPRCSUC4XEQSYPJMU2VBUMY2CI6CG4JIRDO7UJBGVN77JRJQOB6EKR
- Explorer (Tx de Deploy): https://stellar.expert/explorer/testnet/tx/138c358f0f1338b798b014d4d74f5a0ddb5cd481e5523416d33f3fe47dfdd473
- Variável de ambiente: STELLAR_CREDIT_CONTRACT_ID=CAYPRCSUC4XEQSYPJMU2VBUMY2CI6CG4JIRDO7UJBGVN77JRJQOB6EKR
- Log do deploy: logs/contract_deploy_20250916_044921.log

Observações:
- O ID do contrato foi salvo automaticamente em `.env.contract` na raiz do projeto.
- O backend carrega automaticamente o `.env.contract` e mapeia `STELLAR_CREDIT_CONTRACT_ID` para `CONTRACT_ADDRESS` quando necessário.

## Como registrar um novo deploy

1. Execute o script `scripts/deploy_contract.sh`.
2. Confirme o novo Contract ID no arquivo `.env.contract` gerado/atualizado.
3. Atualize as seções de deploy no `README.md` (PT/EN) com:
   - Data/Hora
   - Rede
   - Conta (Public Key)
   - Contract ID
   - Links do explorer (contrato e TX de deploy)
   - Caminho do log
4. Adicione uma nova entrada abaixo com o histórico completo.

## Histórico

- 2025-09-16 04:49:37 — testnet — Contract ID: CAYPRCSUC4XEQSYPJMU2VBUMY2CI6CG4JIRDO7UJBGVN77JRJQOB6EKR — Conta: GCKZ35K7GMUJBFKBOS2YM7FUHATM5FHHFGH7AVNGC5TXLFGV265G33QX — Log: logs/contract_deploy_20250916_044921.log
