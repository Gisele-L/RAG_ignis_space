import os
import sys
from pathlib import Path

import gradio as gr
from langchain_core.messages import AIMessage, HumanMessage


# ============================================================
# CONEXÃO COM O RAG
# ============================================================

PROJECT_DIR = Path(__file__).resolve().parent
SRC_DIR = PROJECT_DIR / "src"

if str(SRC_DIR) not in sys.path:
    sys.path.insert(0, str(SRC_DIR))

from agent import ask_agent  # noqa: E402


# ============================================================
# MEMÓRIA DA SESSÃO
# ============================================================

def state_to_messages(state):
    messages = []

    for item in state or []:
        role = item.get("role")
        content = item.get("content", "")

        if role == "user":
            messages.append(HumanMessage(content=content))
        elif role == "assistant":
            messages.append(AIMessage(content=content))

    return messages


def messages_to_state(messages):
    state = []

    for message in messages:
        if isinstance(message, HumanMessage):
            role = "user"
        elif isinstance(message, AIMessage):
            role = "assistant"
        else:
            continue

        state.append(
            {
                "role": role,
                "content": message.content,
            }
        )

    return state


# ============================================================
# CHAT
# ============================================================

def responder(mensagem, historico_visual, memoria_state):
    if not mensagem or not mensagem.strip():
        return historico_visual, "", memoria_state

    conversation_history = state_to_messages(memoria_state)

    resposta, updated_history = ask_agent(
        mensagem,
        conversation_history,
    )

    historico_visual = (historico_visual or []) + [
        {
            "role": "user",
            "content": mensagem,
        },
        {
            "role": "assistant",
            "content": resposta,
        },
    ]

    return (
        historico_visual,
        "",
        messages_to_state(updated_history),
    )


def limpar():
    return [], "", []


# ============================================================
# INTERFACE
# ============================================================

tema = gr.themes.Soft(
    primary_hue="orange",
    neutral_hue="slate",
)

CSS = """
.gradio-container {
    max-width: 980px !important;
    margin: 0 auto !important;
}

footer {
    display: none !important;
}
"""

with gr.Blocks() as demo:
    memoria = gr.State([])

    gr.Markdown(
        """
# Ignis Space — Assistente Documental

Consulte documentos internos da Ignis Space utilizando o agente RAG.
"""
    )

    chatbot = gr.Chatbot(
        height=520,
        show_label=False,
        placeholder=(
            "Faça uma pergunta sobre propostas, missões, "
            "qualidade, gestão ou documentação técnica."
        ),
    )

    caixa = gr.Textbox(
        placeholder="Digite sua pergunta...",
        show_label=False,
        autofocus=True,
        submit_btn=True,
    )

    btn_limpar = gr.Button(
        "Nova conversa",
        variant="secondary",
    )

    gr.Examples(
        examples=[
            "Qual é o valor total da proposta ORC-2026-028?",
            "Quais são os parâmetros de integração do MT-INT-014?",
            "Quais são os principais riscos operacionais da Ignis Space?",
        ],
        inputs=caixa,
        label="Exemplos",
    )

    caixa.submit(
        responder,
        inputs=[
            caixa,
            chatbot,
            memoria,
        ],
        outputs=[
            chatbot,
            caixa,
            memoria,
        ],
    )

    btn_limpar.click(
        limpar,
        outputs=[
            chatbot,
            caixa,
            memoria,
        ],
    )


# ============================================================
# EXECUÇÃO
# ============================================================

if __name__ == "__main__":
    port = int(os.getenv("PORT", "7860"))

    demo.launch(
        server_name="0.0.0.0",
        server_port=port,
        theme=tema,
        css=CSS,
    )
