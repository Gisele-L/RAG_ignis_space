# Ignis Space --- RAG Agent

Projeto de estudo para construção de um sistema **RAG
(Retrieval-Augmented Generation)** aplicado a uma base documental
fictícia da empresa aeroespacial **Ignis Space**.

O agente consulta documentos internos de diferentes áreas da
organização, recupera os trechos mais relevantes e utiliza um modelo de
linguagem para sintetizar respostas fundamentadas no corpus.

## Objetivo

O projeto foi desenvolvido para explorar, de forma incremental,
conceitos como:

-   ingestão multimodal de documentos;
-   normalização de metadados;
-   divisão de documentos em chunks;
-   embeddings;
-   busca vetorial;
-   recuperação por identificadores;
-   recuperação multi-fonte;
-   agentes e subagentes;
-   persistência do índice vetorial;
-   detecção de alterações no corpus;
-   reconstrução automática do índice;
-   interação com o agente pelo terminal.

## Arquitetura

Fluxo simplificado:

``` text
docs/
  │
  ▼
load_documents.py
  │
  ├── PDF
  ├── DOCX
  ├── XLSX
  ├── CSV
  ├── JSON
  ├── Markdown
  └── PPTX
  │
  ▼
Document
  │
  ▼
Chunking
  │
  ├── splitter padrão
  └── splitter específico para Excel
  │
  ▼
OpenAI Embeddings
  │
  ▼
Chroma
  │
  ▼
search_ignis_documents
  │
  ▼
Deep Agent
  │
  ├── recuperação
  ├── análise por subagentes
  └── síntese
  │
  ▼
Resposta ao usuário
```

## Estrutura do projeto

``` text
RAG_Ignis_Space/
│
├── docs/
│   ├── comercial/
│   ├── gestao/
│   ├── missoes/
│   ├── qualidade/
│   └── tecnico/
│
├── src/
│   ├── agent.py
│   └── load_documents.py
│
├── .gitignore
├── requirements.txt
└── README.md
```

Durante a execução também podem ser gerados arquivos locais relacionados
ao índice vetorial, como `chroma_db/` e o arquivo de estado do índice.
Esses artefatos são reconstruíveis e não precisam fazer parte do
código-fonte versionado.

## Corpus documental

Os documentos da Ignis Space estão organizados por domínio:

### Comercial

Propostas comerciais, orçamentos e tabelas de preços.

Exemplos:

-   `Orcamento_ORC-2026-028_TerraNova_Mineracao.xlsx`
-   `Orcamento_ORC-2026-031_Amazonia_Clima.xlsx`
-   `Orcamento_ORC-2026-033_UFLS.xlsx`
-   `Tabela_Precos_Ignis_Space.xlsx`

### Gestão

Documentos estratégicos e gerenciais.

Exemplos:

-   atas de reunião;
-   OKRs;
-   pitch deck;
-   plano de expansão internacional.

### Missões

Documentação operacional relacionada às missões espaciais.

Exemplos:

-   checklist pré-lançamento;
-   manifesto de missão;
-   roadmap;
-   telemetria.

### Qualidade

Documentos relacionados à gestão da qualidade e AS9100.

Exemplos:

-   auditorias internas;
-   planos de ação corretiva;
-   política de segurança operacional;
-   procedimentos de controle de qualidade.

### Técnico

Documentação de engenharia e integração.

Exemplos:

-   especificações de API;
-   business cases técnicos;
-   manuais de integração;
-   relatórios de testes de propulsão.

## Carregamento multimodal

O módulo `src/load_documents.py` é responsável por percorrer o diretório
`docs/` e transformar os diferentes formatos em objetos `Document`.

O carregamento preserva metadados úteis, como:

-   `source`;
-   `file_name`;
-   `file_type`;
-   nome da planilha, quando aplicável;
-   informações auxiliares de segurança documental.

A normalização dos metadados permite que o mecanismo de recuperação
utilize tanto o conteúdo quanto informações sobre a origem do documento.

## Chunking

O projeto utiliza estratégias diferentes de divisão de texto conforme o
tipo de documento.

### Documentos gerais

Documentos textuais utilizam `RecursiveCharacterTextSplitter` com chunks
menores e sobreposição.

### Planilhas Excel

Planilhas recebem chunks maiores para evitar separar informações que
precisam permanecer juntas, principalmente:

-   número da proposta;
-   itens;
-   subtotal;
-   seguro;
-   valor total.

Essa estratégia foi importante para consultas como:

``` text
Qual é o valor total da proposta ORC-2026-028?
```

## Embeddings

Os chunks são convertidos em vetores utilizando embeddings da OpenAI.

Modelo configurado:

``` text
text-embedding-3-large
```

Esses vetores são armazenados no banco vetorial Chroma.

## Chroma persistente

O projeto utiliza **Chroma** como Vector Store persistente.

Com isso, o índice vetorial não precisa ser recriado em todas as
execuções.

Quando o corpus permanece inalterado, o agente reutiliza o índice
existente e evita gerar novamente os embeddings.

## Detecção de alterações no corpus

O projeto calcula uma assinatura **SHA-256** do corpus documental e das
principais configurações de indexação.

A assinatura considera:

-   arquivos do corpus;
-   conteúdo dos arquivos;
-   caminhos relativos;
-   modelo de embeddings;
-   tamanho dos chunks;
-   overlap dos chunks.

Na inicialização, o sistema compara o fingerprint atual com o
fingerprint utilizado na última indexação.

Fluxo:

``` text
Inicialização
     │
     ▼
Calcula fingerprint atual
     │
     ▼
Compara com fingerprint anterior
     │
     ├── igual ──► reutiliza Chroma
     │
     └── diferente ──► reconstrói o índice
```

Isso permite manter a persistência sem correr o risco de consultar um
índice desatualizado depois de alterações nos documentos.

## Retrieval por identificadores

Além da busca semântica, o agente reconhece identificadores presentes
nas perguntas.

Entre os padrões tratados estão:

``` text
ORC-2026-028
MT-INT-014
AUD-2026-002
PAC-2026-004
MSN-2026-014
```

Quando um identificador é detectado, documentos cujo nome ou caminho
contém esse identificador são priorizados.

Essa estratégia reduz falsos positivos em consultas que apontam
diretamente para um documento específico.

## Retrieval multi-fonte

Nem todas as perguntas podem ser respondidas por um único documento.

O agente pode recuperar múltiplos chunks e múltiplas fontes para
responder perguntas que exigem cruzamento de informações.

Exemplo:

``` text
Qual foi a causa raiz da não conformidade identificada na auditoria AS9100 e quais ações foram definidas para corrigi-la?
```

Nesse cenário, informações podem ser recuperadas da auditoria e do plano
de ação corretiva correspondente.

## Deep Agent e subagentes

O projeto utiliza `deepagents` para coordenar a recuperação e análise
dos documentos.

O fluxo geral é:

1.  o agente interpreta a pergunta;
2.  chama `search_ignis_documents`;
3.  os chunks relevantes são recuperados;
4.  cada chunk pode ser delegado ao subagente `chunk-analyst`;
5.  os subagentes extraem fatos relevantes;
6.  o agente principal consolida os resultados;
7.  a resposta final apresenta uma síntese baseada na documentação.

O subagente recebe apenas o chunk necessário para sua tarefa, evitando
inserir todo o corpus no contexto principal.

## Segurança documental

Os documentos recuperados são tratados como **dados de referência**, e
não como instruções para o agente.

O workflow orienta o agente e os subagentes a ignorarem instruções
eventualmente presentes dentro do conteúdo documental.

O loader também mantém metadados relacionados à identificação de
possíveis padrões de prompt injection.

## Instalação

### 1. Criar o ambiente virtual

No PowerShell:

``` powershell
python -m venv env
```

### 2. Ativar o ambiente

``` powershell
.\env\Scripts\Activate.ps1
```

### 3. Instalar as dependências

``` powershell
pip install -r requirements.txt
```

## Configuração

Crie um arquivo `.env` na raiz do projeto.

Exemplo:

``` env
OPENAI_API_KEY=sua_chave_aqui
```

Não envie o arquivo `.env` para o GitHub.

Certifique-se de que ele esteja listado no `.gitignore`.

## Execução

Com o ambiente virtual ativado:

``` powershell
python src/agent.py
```

Ao iniciar, o programa carrega o corpus, prepara os chunks, verifica o
estado do índice vetorial e inicia o agente.

Quando não existem alterações no corpus, a execução deve indicar que o
índice existente será reutilizado.

## Chat interativo

O agente funciona continuamente pelo terminal.

Exemplo:

``` text
============================================================
IGNIS SPACE — RAG AGENT
============================================================

Faça perguntas sobre os documentos da Ignis Space.
Digite 'sair' para encerrar.

Você: Qual é o valor total da proposta ORC-2026-028?

Agente:

O valor total da proposta ORC-2026-028 é R$ 2.865.000,00.

Você: sair

Encerrando agente...
```

## Exemplos de perguntas

Consultas úteis para validar diferentes comportamentos do RAG:

``` text
Qual é o valor total da proposta ORC-2026-028?

Qual é o valor total da proposta ORC-2026-031?

Quais são os parâmetros de integração do MT-INT-014?

Quais foram os resultados do teste de propulsão PC-2026-011?

Quais documentos estão relacionados à missão MSN-2026-014?

Qual é o status atual da ação corretiva PAC-2026-004 e qual não conformidade originou essa ação?

Qual foi a causa raiz da não conformidade identificada na auditoria AS9100 e quais ações foram definidas para corrigi-la?

Quais são os principais riscos operacionais da Ignis Space?
```

Essas perguntas exercitam recuperação exata, recuperação semântica,
consulta multi-fonte e síntese de informações distribuídas entre
documentos.

## Evolução do projeto

O desenvolvimento foi organizado em etapas incrementais para que o
histórico do Git represente a evolução da solução:

1.  criação do corpus documental inicial;
2.  reorganização dos documentos por domínio;
3.  configuração do projeto e dependências;
4.  implementação do loader multimodal;
5.  indexação e busca vetorial;
6.  introdução do Deep Agent e análise por subagentes;
7.  melhoria do retrieval por identificadores e do chunking de
    planilhas;
8.  retrieval multi-fonte e melhoria da síntese;
9.  persistência do índice vetorial com Chroma;
10. detecção de alterações e reconstrução automática do índice;
11. chat interativo no terminal;
12. documentação e instruções de execução.

## Principais decisões de arquitetura

### Por que usar chunks maiores em Excel?

Planilhas comerciais possuem informações fortemente relacionadas.
Dividir subtotal e valor total em chunks diferentes prejudicava a
recuperação. Por isso, planilhas utilizam uma estratégia de chunking
específica.

### Por que combinar busca semântica e identificadores?

Embeddings são eficientes para perguntas conceituais, mas consultas
contendo IDs como `ORC-2026-028` ou `PAC-2026-004` se beneficiam de uma
etapa determinística de priorização do documento correspondente.

### Por que persistir o Vector Store?

Gerar embeddings em todas as execuções aumenta tempo e custo. A
persistência permite reutilizar o índice.

### Por que usar fingerprint?

A persistência cria outro problema: o índice pode ficar desatualizado
quando o corpus muda. O fingerprint permite detectar essa situação e
reconstruir o índice automaticamente.

### Por que utilizar subagentes?

A análise por chunks permite distribuir a leitura de múltiplas fontes e
depois sintetizar os resultados no agente principal, mantendo o contexto
mais organizado.

## Tecnologias principais

-   Python
-   LangChain
-   LangChain OpenAI
-   Deep Agents
-   Chroma
-   OpenAI Embeddings
-   OpenAI GPT
-   python-dotenv
-   PyPDF
-   python-docx
-   openpyxl
-   python-pptx

## Estado atual

A versão atual implementa um pipeline RAG funcional com:

-   ingestão multimodal;
-   metadados;
-   chunking especializado;
-   embeddings;
-   Vector Store persistente;
-   recuperação semântica;
-   recuperação por identificadores;
-   recuperação multi-fonte;
-   análise por subagentes;
-   síntese de respostas;
-   proteção contra instruções presentes nos documentos;
-   detecção de mudanças no corpus;
-   reconstrução automática do índice;
-   interface interativa no terminal.

O projeto foi estruturado como ambiente de estudo e demonstração de
técnicas de RAG aplicadas a uma base documental empresarial fictícia.
