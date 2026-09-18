# ADR 002: Isolamento de Ecossistemas (Monorepo) e Clean Architecture

## Contexto
O projeto "Gestão Microestrutural" abrange duas tecnologias com motores de compilação distintos: o backend em C# (.NET 8 / MSBuild) e o frontend em Angular (Node.js / npm). Colocar o arquivo de orquestração `.sln` na raiz do repositório forçaria o compilador C# a rastrear e tentar interpretar o ecossistema JavaScript/TypeScript, gerando acoplamento artificial, lentidão sistêmica no *build* e potenciais conflitos nas esteiras de Integração Contínua (CI/CD). Adicionalmente, o backend exige a imposição rigorosa do isolamento das regras de negócio para suportar a complexidade do CQRS e do Event Sourcing.

## Decisão
1. **Monorepo Desacoplado:** Adotamos uma estrutura de Monorepo com isolamento físico na raiz do projeto (`src/frontend/` e `src/backend/`). O arquivo `GestaoMicroestrutural.sln` ficará restrito ao diretório do backend, atuando exclusivamente sobre o ecossistema .NET.
2. **Clean Architecture (Ortogonalidade):** O backend será estruturado em quatro camadas com referências de dependência estritamente unidirecionais:
    - `GestaoMicroestrutural.Domain`: O coração do sistema, contendo raízes de agregação e eventos. Não possui dependências externas.
    - `GestaoMicroestrutural.Application`: Orquestra os casos de uso (Commands/Queries via MediatR), dependendo exclusivamente do `Domain`.
    - `GestaoMicroestrutural.Infrastructure`: Implementação de persistência (EventStore e ReadModel), dependendo exclusivamente do `Domain`.
    - `GestaoMicroestrutural.Api`: Porta de entrada e roteamento, dependendo de `Application` e `Infrastructure`.

## Consequências
- **Prós:** Ortogonalidade arquitetural alcançada. As esteiras de CI/CD (GitHub Actions) poderão operar em paralelo de forma autônoma. O *deploy* do Angular para a Vercel e da API para provedores de nuvem (Azure/Render) ocorrerá sem bloqueios mútuos. O núcleo do sistema fica matematicamente protegido contra vazamentos de regras de negócio.
- **Contras:** Maior necessidade de navegação de diretórios durante o desenvolvimento no terminal e a obrigação de manter dois arquivos de configuração independentes para a automação de *build*.