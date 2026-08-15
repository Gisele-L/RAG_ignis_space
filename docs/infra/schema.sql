-- ============================================================
-- IGNIS SPACE — SCHEMA RELACIONAL
-- Dialeto: Oracle SQL (Oracle Autonomous Database)
-- Observação: para desenvolvimento/teste local, o mesmo schema
-- roda em SQLite/PostgreSQL com pequenos ajustes de tipo
-- (ver notas ao final do arquivo).
-- ============================================================

-- ------------------------------------------------------------
-- 1. CLIENTES
-- ------------------------------------------------------------
CREATE TABLE clientes (
    id              VARCHAR2(10)  PRIMARY KEY,   -- ex: CLI-0001
    razao_social    VARCHAR2(150) NOT NULL,
    cnpj            VARCHAR2(18)  NOT NULL UNIQUE,
    endereco        VARCHAR2(200),
    segmento        VARCHAR2(150),
    contato_nome    VARCHAR2(100),
    contato_email   VARCHAR2(100),
    status          VARCHAR2(30)  DEFAULT 'Cliente ativo',
    data_cadastro   DATE          DEFAULT SYSDATE
);

-- ------------------------------------------------------------
-- 2. LEADS (prospects / orçamentos ainda não convertidos)
-- ------------------------------------------------------------
CREATE TABLE leads (
    id              VARCHAR2(10)  PRIMARY KEY,   -- ex: LEAD-0001
    razao_social    VARCHAR2(150) NOT NULL,
    cnpj            VARCHAR2(18)  NOT NULL UNIQUE,
    endereco        VARCHAR2(200),
    segmento        VARCHAR2(150),
    contato_nome    VARCHAR2(100),
    contato_email   VARCHAR2(100),
    status          VARCHAR2(60),
    data_cadastro   DATE          DEFAULT SYSDATE
);

-- ------------------------------------------------------------
-- 3. FORNECEDORES
-- ------------------------------------------------------------
CREATE TABLE fornecedores (
    id              VARCHAR2(10)  PRIMARY KEY,   -- ex: FOR-0001
    razao_social    VARCHAR2(150) NOT NULL,
    cnpj            VARCHAR2(18)  NOT NULL UNIQUE,
    endereco        VARCHAR2(200),
    fornece         VARCHAR2(200),
    contato_nome    VARCHAR2(100),
    status          VARCHAR2(30)  DEFAULT 'Fornecedor ativo'
);

-- ------------------------------------------------------------
-- 4. COLABORADORES
-- ------------------------------------------------------------
CREATE TABLE colaboradores (
    id              VARCHAR2(10)  PRIMARY KEY,   -- ex: COL-0001
    nome            VARCHAR2(100) NOT NULL,
    cargo           VARCHAR2(100),
    departamento    VARCHAR2(60),
    data_admissao   DATE
);

-- ------------------------------------------------------------
-- 5. INVESTIDORES
-- ------------------------------------------------------------
CREATE TABLE investidores (
    id              VARCHAR2(10)  PRIMARY KEY,   -- ex: INV-0001
    nome            VARCHAR2(150) NOT NULL,
    tipo            VARCHAR2(60),
    rodada          VARCHAR2(60),
    representante   VARCHAR2(100)
);

-- ------------------------------------------------------------
-- 6. MISSÕES (lançamentos)
-- ------------------------------------------------------------
CREATE TABLE missoes (
    id                      VARCHAR2(15) PRIMARY KEY,  -- ex: MSN-2026-014
    data_lancamento_prevista DATE,
    orbita                  VARCHAR2(50),               -- ex: SSO 550km
    altitude_km             NUMBER(6),
    veiculo_lancador        VARCHAR2(100),
    status                  VARCHAR2(30) DEFAULT 'Planejada'
        CHECK (status IN ('Planejada','Confirmada','Lançada','Concluída','Cancelada'))
);

-- ------------------------------------------------------------
-- 7. MISSAO_CARGAS (tabela de junção N:N — quais clientes têm
--    carga em qual missão; uma missão rideshare tem várias)
-- ------------------------------------------------------------
CREATE TABLE missao_cargas (
    id              NUMBER        GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    missao_id       VARCHAR2(15)  NOT NULL REFERENCES missoes(id),
    cliente_id      VARCHAR2(10)  NOT NULL REFERENCES clientes(id),
    tipo_carga      VARCHAR2(60),      -- ex: CubeSat 6U
    massa_kg        NUMBER(6,2),
    CONSTRAINT uq_missao_cliente UNIQUE (missao_id, cliente_id)
);

-- ------------------------------------------------------------
-- 8. ORÇAMENTOS (propostas comerciais para leads)
-- ------------------------------------------------------------
CREATE TABLE orcamentos (
    id                  VARCHAR2(15) PRIMARY KEY,   -- ex: ORC-2026-031
    lead_id             VARCHAR2(10) NOT NULL REFERENCES leads(id),
    valor_estimado      NUMBER(12,2),
    data_envio          DATE,
    status              VARCHAR2(60),
    missao_referencia   VARCHAR2(200)   -- descrição textual da missão-alvo (ainda sem missao_id, pois não foi contratada)
);

-- ------------------------------------------------------------
-- 9. CONTRATOS (orçamentos convertidos em cliente + missão)
-- ------------------------------------------------------------
CREATE TABLE contratos (
    id                  VARCHAR2(20) PRIMARY KEY,   -- ex: IGN-LAU-2026-0143
    cliente_id          VARCHAR2(10) NOT NULL REFERENCES clientes(id),
    missao_id           VARCHAR2(15) NOT NULL REFERENCES missoes(id),
    valor_total          NUMBER(12,2),
    data_assinatura      DATE,
    status               VARCHAR2(30) DEFAULT 'Vigente'
        CHECK (status IN ('Vigente','Concluído','Rescindido'))
);

-- ------------------------------------------------------------
-- 10. PEDIDOS DE COMPRA (fornecimento de componentes)
-- ------------------------------------------------------------
CREATE TABLE pedidos_compra (
    id              VARCHAR2(15) PRIMARY KEY,   -- ex: PC-2026-007
    fornecedor_id   VARCHAR2(10) NOT NULL REFERENCES fornecedores(id),
    item            VARCHAR2(200),
    valor           NUMBER(12,2),
    data_pedido     DATE,
    status          VARCHAR2(30) DEFAULT 'Entregue'
        CHECK (status IN ('Pendente','Em produção','Entregue','Cancelado'))
);

-- ============================================================
-- ÍNDICES DE APOIO (consultas mais comuns do agente)
-- ============================================================
CREATE INDEX idx_missao_cargas_missao   ON missao_cargas(missao_id);
CREATE INDEX idx_missao_cargas_cliente  ON missao_cargas(cliente_id);
CREATE INDEX idx_contratos_cliente      ON contratos(cliente_id);
CREATE INDEX idx_contratos_missao       ON contratos(missao_id);
CREATE INDEX idx_orcamentos_lead        ON orcamentos(lead_id);
CREATE INDEX idx_pedidos_fornecedor     ON pedidos_compra(fornecedor_id);

-- ============================================================
-- EXEMPLOS DE CONSULTA (o tipo de pergunta que o agente resolve
-- via function calling / tool use, não via busca semântica)
-- ============================================================

-- "Quais clientes têm carga na missão MSN-2026-014?"
-- SELECT c.razao_social, mc.tipo_carga, mc.massa_kg
-- FROM missao_cargas mc
-- JOIN clientes c ON c.id = mc.cliente_id
-- WHERE mc.missao_id = 'MSN-2026-014';

-- "Qual o valor total de orçamentos em aberto (leads)?"
-- SELECT SUM(valor_estimado) FROM orcamentos WHERE status LIKE '%análise%' OR status LIKE '%aguardando%';

-- "Quais contratos estão vigentes com a AgroVisão?"
-- SELECT ct.* FROM contratos ct
-- JOIN clientes c ON c.id = ct.cliente_id
-- WHERE c.razao_social = 'AgroVisão Sensoriamento Remoto Ltda.' AND ct.status = 'Vigente';

-- ============================================================
-- NOTAS DE PORTABILIDADE (Oracle -> SQLite, para dev local)
-- ============================================================
-- 1. GENERATED ALWAYS AS IDENTITY  -> SQLite: INTEGER PRIMARY KEY AUTOINCREMENT
-- 2. VARCHAR2(n)                    -> SQLite: TEXT (tamanho não é imposto)
-- 3. NUMBER(p,s)                    -> SQLite: REAL ou NUMERIC
-- 4. SYSDATE                        -> SQLite: CURRENT_DATE
-- 5. CHECK (...) IN (...)           -> suportado igual em ambos
