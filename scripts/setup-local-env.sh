#!/bin/bash

echo "====================================================="
echo " GESTÃO MICROESTRUTURAL - Verificação e Provisionamento de Ambiente  "
echo "====================================================="

command -v dotnet >/dev/null 2>&1 || { echo >&2 "Erro: .NET 8 SDK não instalado. Abortando."; exit 1; }
command -v node >/dev/null 2>&1 || { echo >&2 "Erro: Node.js (Angular) não instalado. Abortando."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo >&2 "Erro: Docker não instalado. Abortando."; exit 1; }

echo "Todas as dependências (CLI) foram validadas com sucesso."

echo "Provisionando infraestrutura de dados via Docker Compose..."
cd ../deploy || exit
docker-compose up -d

echo "====================================================="
echo " Provisionamento concluído! "
echo " PostgreSQL rodando na porta 5432."
echo " PgAdmin rodando em http://localhost:5050"
echo "====================================================="