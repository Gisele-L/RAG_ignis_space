-- ============================================================
-- IGNIS SPACE — POPULAÇÃO DO SCHEMA (dados fictícios)
-- Dialeto: Oracle SQL (compatível com adaptação p/ SQLite/Postgres)
-- Depende de schema.sql já ter sido executado.
-- ============================================================

-- ------------------------------------------------------------
-- CLIENTES
-- ------------------------------------------------------------
INSERT INTO clientes (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('CLI-0001', 'Nebula Geodata Pesquisas Ltda.', '58.219.043/0001-77', 'Rua Verbo Divino, 1400, Sala 82, Chácara Santo Antônio, São Paulo - SP, CEP 04719-002', 'Sensoriamento remoto e geodados agrícolas', 'Marina Kessler Prado', 'marina.prado@nebulageodata.com.br', 'Cliente ativo');

INSERT INTO clientes (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('CLI-0002', 'Constelar Telecom S.A.', '27.904.318/0001-52', 'Av. das Nações Unidas, 12901, Torre Norte, 18º andar, São Paulo - SP, CEP 04578-000', 'Telecomunicações e testes de conectividade em órbita', 'Rodrigo Almeida Bastos', 'r.bastos@constelartelecom.com.br', 'Cliente ativo');

INSERT INTO clientes (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('CLI-0003', 'AgroVisão Sensoriamento Remoto Ltda.', '33.671.520/0001-09', 'Rodovia SP-330, km 295, Distrito Industrial, Ribeirão Preto - SP, CEP 14078-400', 'Monitoramento agrícola via imageamento orbital', 'Fernanda Costa Ribeiro', 'fernanda@agrovisao.agr.br', 'Cliente ativo');

INSERT INTO clientes (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('CLI-0004', 'Litoral Blue Oceanografia Ltda.', '19.483.276/0001-64', 'Av. Beira Mar, 550, Conjunto 301, Florianópolis - SC, CEP 88015-700', 'Monitoramento oceânico e climático', 'Tiago Henrique Souza Lima', 'tiago.lima@litoralblue.com.br', 'Cliente ativo');

INSERT INTO clientes (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('CLI-0005', 'Instituto Vale do Paraíba de Pesquisas Aeroespaciais', '05.912.446/0001-21', 'Praça Marechal Eduardo Gomes, 50, Vila das Acácias, São José dos Campos - SP, CEP 12228-900', 'Pesquisa acadêmica — CubeSat universitário', 'Prof. Dr. Eduardo Nakamura Vieira', 'e.vieira@ivppa.edu.br', 'Cliente ativo');

-- ------------------------------------------------------------
-- LEADS
-- ------------------------------------------------------------
INSERT INTO leads (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('LEAD-0001', 'Amazônia Clima Ltda.', '42.098.135/0001-88', 'Av. Djalma Batista, 1661, Chapada, Manaus - AM, CEP 69050-010', 'Monitoramento climático e desmatamento', 'Camila Duarte Freitas', 'camila@amazoniaclima.eco.br', 'Orçamento em análise');

INSERT INTO leads (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('LEAD-0002', 'TerraNova Mineração S.A.', '16.837.590/0001-45', 'Rua dos Inconfidentes, 1000, Savassi, Belo Horizonte - MG, CEP 30140-120', 'Monitoramento geológico e de bacias de rejeito', 'Paulo César Andrade Melo', 'paulo.melo@terranova.min.br', 'Orçamento enviado, aguardando aprovação');

INSERT INTO leads (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('LEAD-0003', 'Skyline Connect Telecomunicações Ltda.', '24.560.982/0001-13', 'Av. Cristóvão Colombo, 900, Floresta, Porto Alegre - RS, CEP 90560-002', 'Conectividade IoT via nanossatélites', 'Bruno Salles Tavares', 'bruno@skylineconnect.com.br', 'Reunião de descoberta realizada, orçamento não formalizado');

INSERT INTO leads (id, razao_social, cnpj, endereco, segmento, contato_nome, contato_email, status) VALUES
('LEAD-0004', 'Universidade Federal do Litoral Sul (UFLS)', '10.274.813/0001-96', 'Rodovia BR-101, km 210, Campus Universitário, Laguna - SC, CEP 88790-000', 'Pesquisa acadêmica — CubeSat de telemetria climática', 'Profa. Dra. Luiza Menezes Cardoso', 'luiza.cardoso@ufls.edu.br', 'Orçamento em análise');

-- ------------------------------------------------------------
-- FORNECEDORES
-- ------------------------------------------------------------
INSERT INTO fornecedores (id, razao_social, cnpj, endereco, fornece, contato_nome, status) VALUES
('FOR-0001', 'PropTech Componentes Aeroespaciais Ltda.', '12.345.678/0001-90', 'Rua Itaipu, 250, Distrito Industrial, São José dos Campos - SP, CEP 12235-005', 'Sistemas de propulsão a gás frio e propelentes', 'Ricardo Nogueira Peixoto', 'Fornecedor ativo');

INSERT INTO fornecedores (id, razao_social, cnpj, endereco, fornece, contato_nome, status) VALUES
('FOR-0002', 'SolarCell Brasil Energia Fotovoltaica Ltda.', '23.456.789/0001-01', 'Av. Perimetral, 3400, Distrito Industrial, Hortolândia - SP, CEP 13186-901', 'Painéis solares e células fotovoltaicas espaciais', 'Juliana Prado Martins', 'Fornecedor ativo');

INSERT INTO fornecedores (id, razao_social, cnpj, endereco, fornece, contato_nome, status) VALUES
('FOR-0003', 'AviônicaBR Sistemas Embarcados Ltda.', '34.567.890/0001-12', 'Rua Conceição, 233, Centro, Campinas - SP, CEP 13010-050', 'Computador de bordo, sistemas de telemetria e comunicação', 'Diego Fontoura Cavalcanti', 'Fornecedor ativo');

INSERT INTO fornecedores (id, razao_social, cnpj, endereco, fornece, contato_nome, status) VALUES
('FOR-0004', 'Compósitos SJC Materiais Estruturais Ltda.', '45.678.901/0001-23', 'Rua Doutor Elias Barbosa Gomes, 780, Jardim Satélite, São José dos Campos - SP, CEP 12230-030', 'Estruturas em fibra de carbono e chassis de dispensers', 'Vanessa Ribeiro Guimarães', 'Fornecedor ativo');

-- ------------------------------------------------------------
-- COLABORADORES
-- ------------------------------------------------------------
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0001', 'Rafael Augusto Monteiro', 'CEO e Cofundador', 'Diretoria', DATE '2019-03-01');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0002', 'Beatriz Salomão Ferreira', 'CTO e Cofundadora', 'Engenharia', DATE '2019-03-01');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0003', 'André Luiz Barreto Correia', 'Diretor Financeiro', 'Financeiro', DATE '2020-06-15');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0004', 'Camila Rezende Duarte', 'Head de Engenharia de Propulsão', 'Engenharia', DATE '2020-09-01');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0005', 'Otávio Guedes Nascimento', 'Head de Operações de Lançamento', 'Operações', DATE '2021-02-10');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0006', 'Patrícia Lemos Andrade', 'Gerente de Qualidade (AS9100)', 'Qualidade', DATE '2021-08-01');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0007', 'Gustavo Ferraz Siqueira', 'Gerente Comercial', 'Comercial', DATE '2022-01-17');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0008', 'Renata Vasconcelos Pires', 'Analista de Compliance Regulatório', 'Jurídico e Compliance', DATE '2022-04-04');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0009', 'Lucas Hideki Tanaka', 'Engenheiro de Aviônica Sênior', 'Engenharia', DATE '2022-07-11');
INSERT INTO colaboradores (id, nome, cargo, departamento, data_admissao) VALUES ('COL-0010', 'Sabrina Coutinho Farias', 'Coordenadora de RH', 'Recursos Humanos', DATE '2023-02-20');

-- ------------------------------------------------------------
-- INVESTIDORES
-- ------------------------------------------------------------
INSERT INTO investidores (id, nome, tipo, rodada, representante) VALUES
('INV-0001', 'Nebulosa Ventures', 'Fundo de Venture Capital', 'Seed (2020)', 'Felipe Aragão Nogueira');
INSERT INTO investidores (id, nome, tipo, rodada, representante) VALUES
('INV-0002', 'Aurora Capital Partners', 'Fundo de Venture Capital', 'Série A (2022)', 'Helena Marchetti Souza');
INSERT INTO investidores (id, nome, tipo, rodada, representante) VALUES
('INV-0003', 'Fundo Nacional de Inovação Aeroespacial', 'Fundo de fomento público-privado', 'Série A (2022) e Série B (2025)', 'Marcos Vinícius Teles Rocha');

-- ------------------------------------------------------------
-- MISSÕES
-- (MSN-2025-009 já lançada; MSN-2026-014 confirmada; MSN-2026-021 em planejamento)
-- ------------------------------------------------------------
INSERT INTO missoes (id, data_lancamento_prevista, orbita, altitude_km, veiculo_lancador, status) VALUES
('MSN-2025-009', DATE '2025-11-10', 'SSO', 550, 'Ignis Vector-1', 'Concluída');

INSERT INTO missoes (id, data_lancamento_prevista, orbita, altitude_km, veiculo_lancador, status) VALUES
('MSN-2026-014', DATE '2026-09-20', 'SSO', 550, 'Ignis Vector-1', 'Confirmada');

INSERT INTO missoes (id, data_lancamento_prevista, orbita, altitude_km, veiculo_lancador, status) VALUES
('MSN-2026-021', DATE '2026-12-05', 'LEO', 600, 'Ignis Vector-1', 'Planejada');

-- ------------------------------------------------------------
-- MISSAO_CARGAS (quais clientes estão em cada missão rideshare)
-- ------------------------------------------------------------
INSERT INTO missao_cargas (missao_id, cliente_id, tipo_carga, massa_kg) VALUES ('MSN-2025-009', 'CLI-0003', 'CubeSat 3U', 4.2);
INSERT INTO missao_cargas (missao_id, cliente_id, tipo_carga, massa_kg) VALUES ('MSN-2026-014', 'CLI-0001', 'CubeSat 6U', 9.6);
INSERT INTO missao_cargas (missao_id, cliente_id, tipo_carga, massa_kg) VALUES ('MSN-2026-014', 'CLI-0004', 'CubeSat 3U', 4.5);
INSERT INTO missao_cargas (missao_id, cliente_id, tipo_carga, massa_kg) VALUES ('MSN-2026-021', 'CLI-0002', 'CubeSat 12U', 18.0);
INSERT INTO missao_cargas (missao_id, cliente_id, tipo_carga, massa_kg) VALUES ('MSN-2026-021', 'CLI-0005', 'CubeSat 1U', 1.3);

-- ------------------------------------------------------------
-- CONTRATOS (um por cliente/missão)
-- ------------------------------------------------------------
INSERT INTO contratos (id, cliente_id, missao_id, valor_total, data_assinatura, status) VALUES
('IGN-LAU-2025-0089', 'CLI-0003', 'MSN-2025-009', 1780000.00, DATE '2025-06-18', 'Concluído');

INSERT INTO contratos (id, cliente_id, missao_id, valor_total, data_assinatura, status) VALUES
('IGN-LAU-2026-0143', 'CLI-0001', 'MSN-2026-014', 2108250.00, DATE '2026-04-02', 'Vigente');

INSERT INTO contratos (id, cliente_id, missao_id, valor_total, data_assinatura, status) VALUES
('IGN-LAU-2026-0144', 'CLI-0004', 'MSN-2026-014', 1932000.00, DATE '2026-04-09', 'Vigente');

INSERT INTO contratos (id, cliente_id, missao_id, valor_total, data_assinatura, status) VALUES
('IGN-LAU-2026-0158', 'CLI-0002', 'MSN-2026-021', 3410000.00, DATE '2026-07-01', 'Vigente');

INSERT INTO contratos (id, cliente_id, missao_id, valor_total, data_assinatura, status) VALUES
('IGN-LAU-2026-0159', 'CLI-0005', 'MSN-2026-021', 1925000.00, DATE '2026-07-14', 'Vigente');

-- ------------------------------------------------------------
-- ORÇAMENTOS (leads — nem todo lead tem orçamento formalizado)
-- ------------------------------------------------------------
INSERT INTO orcamentos (id, lead_id, valor_estimado, data_envio, status, missao_referencia) VALUES
('ORC-2026-031', 'LEAD-0001', 1740000.00, DATE '2026-07-22', 'Em análise pelo cliente', 'CubeSat 3U para monitoramento de queimadas — janela pretendida Q1 2027');

INSERT INTO orcamentos (id, lead_id, valor_estimado, data_envio, status, missao_referencia) VALUES
('ORC-2026-028', 'LEAD-0002', 2865000.00, DATE '2026-06-30', 'Aguardando aprovação interna do cliente', 'CubeSat 6U para monitoramento de bacias de rejeito — janela pretendida Q4 2026');

INSERT INTO orcamentos (id, lead_id, valor_estimado, data_envio, status, missao_referencia) VALUES
('ORC-2026-033', 'LEAD-0004', 1690000.00, DATE '2026-07-28', 'Em análise', 'CubeSat 3U de telemetria climática — janela pretendida Q2 2027');

-- ------------------------------------------------------------
-- PEDIDOS DE COMPRA (fornecimento de componentes)
-- ------------------------------------------------------------
INSERT INTO pedidos_compra (id, fornecedor_id, item, valor, data_pedido, status) VALUES
('PC-2026-011', 'FOR-0001', 'Módulo de propulsão a gás frio — lote de 3 unidades', 412000.00, DATE '2026-05-12', 'Entregue');

INSERT INTO pedidos_compra (id, fornecedor_id, item, valor, data_pedido, status) VALUES
('PC-2026-012', 'FOR-0002', 'Painéis solares dobráveis 6U — lote de 4 unidades', 268000.00, DATE '2026-05-20', 'Entregue');

INSERT INTO pedidos_compra (id, fornecedor_id, item, valor, data_pedido, status) VALUES
('PC-2026-013', 'FOR-0003', 'Computador de bordo redundante — lote de 5 unidades', 590000.00, DATE '2026-06-02', 'Em produção');

INSERT INTO pedidos_compra (id, fornecedor_id, item, valor, data_pedido, status) VALUES
('PC-2026-014', 'FOR-0004', 'Estrutura de fibra de carbono para dispenser 12U', 175000.00, DATE '2026-06-15', 'Entregue');

INSERT INTO pedidos_compra (id, fornecedor_id, item, valor, data_pedido, status) VALUES
('PC-2026-015', 'FOR-0001', 'Propelente não tóxico — reposição trimestral', 98000.00, DATE '2026-07-01', 'Pendente');

COMMIT;
