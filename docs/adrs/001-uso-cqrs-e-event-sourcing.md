# ADR 001: Adoção de CQRS e Event Sourcing

## Contexto
O sistema precisa gerenciar a substituição de componentes microestruturais de hardware (ex: memórias, processadores). O modelo tradicional (CRUD) que sobrescreve dados de estado (UPDATE/DELETE) não atende aos requisitos de prestação de contas do setor público (Lei 4.320/64), causando perda de histórico de manutenções.

## Decisão
Abandonamos o modelo CRUD em favor dos padrões CQRS (Command Query Responsibility Segregation) acoplado ao Event Sourcing.
- O banco de dados de escrita (Write Model) operará em formato Append-Only, registrando apenas eventos imutáveis (`EventoAuditoria`).
- O banco de dados de leitura (Read Model) será achatado para consultas rápidas, atualizado de forma assíncrona.

## Consequências
- **Prós:** Imutabilidade lógica, auditoria perfeita do ciclo de vida do equipamento, aderência às normativas governamentais e facilidade de depuração temporal (viagem no tempo do estado do ativo).
- **Contras:** Aumento drástico na complexidade acidental (necessidade de brokers, projeções e tratamento de consistência eventual) e curva de aprendizado maior para novos desenvolvedores.