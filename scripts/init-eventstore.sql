CREATE SCHEMA IF NOT EXISTS event_store;

CREATE TABLE IF NOT EXISTS event_store.EventoAuditoria (
    IdTransacao UUID PRIMARY KEY,
    AggregateId UUID NOT NULL,
    TenantId VARCHAR(50) NOT NULL,
    TipoEvento VARCHAR(100) NOT NULL,
    PayloadJson JSONB NOT NULL,
    DataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    IdUsuarioResponsavel UUID NOT NULL
);

CREATE SCHEMA IF NOT EXISTS read_model;