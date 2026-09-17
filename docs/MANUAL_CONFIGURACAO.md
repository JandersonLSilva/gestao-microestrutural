# Manual de Configuração e Estrutura Arquitetural - DIMASU

## 1. Visão Geral e Domínio
Este repositório contém o Sistema de Gestão Microestrutural para Controle e Auditoria de Equipamentos de Informática. O domínio principal resolve a rastreabilidade espacial e temporal de componentes fracionados, com auditoria rigorosa de manutenções.

## 2. Gerência de Configuração e Governança
- **Proteção de Branches:** As branches `main` (Produção) e `develop` (Desenvolvimento) são bloqueadas para commits diretos.
- **Pull Requests (PR):** Toda integração exige a abertura de um PR utilizando o template oficial (`.github/PULL_REQUEST_TEMPLATE.md`).
- **Conventional Commits:** Uso obrigatório de prefixos semânticos (`feat`, `fix`, `chore`, `docs`) para rastreabilidade de histórico.
- **Hotfixes:** Correções críticas em produção devem derivar da `main` e ser integradas de volta tanto na `main` quanto na `develop`.

## 3. Diretrizes de Arquitetura e Extensibilidade
- **Ortogonalidade (Multi-tenância):** O sistema prevê o uso da propriedade `TenantId` nas Raízes de Agregação, garantindo que o núcleo suporte a expansão para outros setores sem refatoração do domínio base.
- **Documentação (ADR):** Toda decisão arquitetural de alto impacto deve ser registrada em um arquivo na pasta `docs/adrs/`.