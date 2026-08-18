from dotenv import load_dotenv

from langchain_core.vectorstores import InMemoryVectorStore
from langchain_openai import OpenAIEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter

from load_documents import load_documents


# ============================================================
# CONFIGURAÇÃO
# ============================================================

load_dotenv()


# ============================================================
# 1. CARREGAR DOCUMENTOS
# ============================================================

print("Carregando documentos da Ignis Space...")

docs = load_documents()

print(
    f"Total de documentos carregados: {len(docs)}"
)

total_characters = sum(
    len(document.page_content)
    for document in docs
)

print(
    f"Total de caracteres: {total_characters}"
)


# ============================================================
# 2. DIVIDIR DOCUMENTOS EM CHUNKS
# ============================================================

text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=200,
)

all_splits = text_splitter.split_documents(
    docs
)

print(
    f"Chunks gerados: {len(all_splits)}"
)


# ============================================================
# 3. OPENAI EMBEDDINGS
# ============================================================

embeddings = OpenAIEmbeddings(
    model="text-embedding-3-large"
)


# ============================================================
# 4. VECTOR STORE
# ============================================================

vector_store = InMemoryVectorStore(
    embeddings
)

print(
    "Indexando chunks no VectorStore..."
)

vector_store.add_documents(
    documents=all_splits
)

print(
    f"Chunks indexados: {len(all_splits)}"
)


# ============================================================
# 5. TESTE DE RETRIEVAL
# ============================================================

EXAMPLE_QUERY = (
    "Qual foi a não conformidade identificada "
    "na auditoria interna AS9100?"
)


if __name__ == "__main__":

    print()
    print("=" * 60)
    print("TESTE DE BUSCA VETORIAL")
    print("=" * 60)
    print()

    retrieved_docs = (
        vector_store.similarity_search(
            EXAMPLE_QUERY,
            k=4,
        )
    )

    print(
        f"Pergunta: {EXAMPLE_QUERY}"
    )

    print()

    print(
        f"Chunks recuperados: "
        f"{len(retrieved_docs)}"
    )

    for index, document in enumerate(
        retrieved_docs,
        start=1,
    ):

        print()
        print("-" * 60)

        print(
            f"RESULTADO {index}"
        )

        print(
            "Fonte:",
            document.metadata.get(
                "source",
                "unknown",
            ),
        )

        print()

        print(
            document.page_content[:1000]
        )