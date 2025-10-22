# 🧠 Neuro-Symbolic AI Scientist Agent

This project implements a **distributed AI Research Scientist** designed to accelerate discovery in fields like Alzheimer’s disease (AD) by generating, validating, and designing scientifically rigorous, actionable experiments.

---

## 🎯 Project Goal

To **automate the scientific discovery process** — from literature retrieval to laboratory blueprint — by combining the **creative intuition of Large Language Models (LLMs)** with the **logical rigor of Symbolic AI**.

---

## ✨ Key Features & Innovations

| Feature | Description | Technologies |
|---------|------------|-------------|
| **Scientific Rigor (Symbolic Edge)** | Hypotheses are formally validated using the **Z3 SMT Solver**, ensuring logical consistency against a knowledge base of known AD facts (e.g., “Aβ clearance does not guarantee cognitive improvement”). | Z3, Python |
| **Actionable Output** | Generates a **full experiment blueprint**, including models (e.g., **5xFAD mice**), treatment groups, outcomes (e.g., **Morris water maze**), and study duration. Exportable as **JSON, LaTeX, PDF**. | Python, LaTeX, JSON |
| **Scalable Architecture** | Built on **4 independent microservices** using Docker and FastAPI, enabling parallel development and modular testing. | Docker, FastAPI, JSON/HTTP |
| **Advanced LLM Integration** | Uses **LLaMA 3** (via Cerebras API) for both creative hypothesis generation and structured experiment design. | LLaMA 3, Cerebras API |
| **Professional Dashboard** | A **Streamlit UI** (Port 8501) orchestrates the pipeline, displaying each step from query to final blueprint. | Streamlit, Python |

---

## 🏗️ Architecture & Workflow

The pipeline separates **neural** and **symbolic** roles:

| Step | Service Name (Port) | Owner Role | Purpose & Technology |
|------|-------------------|------------|-------------------|
| 1 | `ingest-search` (8000) | Neural (Person A) | Retrieves top 3 relevant Alzheimer’s papers using semantic search. | FAISS/Chroma |
| 2 | `hypothesis-gen` (8001) | Neural (Person A) | Generates a testable hypothesis from knowledge gaps. | LLaMA 3 |
| 3 | `z3-validator` (8002) | Symbolic (Person B) | Validates hypothesis against known biological facts. | Z3 SMT Solver |
| 4 | `experiment-design` (8003) | Symbolic (Person B) | Converts validated hypotheses into a detailed experimental blueprint. | LLaMA 3 |
| Interface | `dashboard` (8501) | Symbolic (Person B) | Streamlit UI for end-to-end orchestration and downloads. | Streamlit |

---

## 🚀 Getting Started

### Prerequisites

- Docker Desktop (with Docker Compose)  
- Git  
- Python 3.10+ (optional, for local development without Docker)  

### Environment Variables

Create `.env` from `.env.example`:

CEREBRAS_API_KEY=your_cerebras_api_key_here
PINECONE_API_KEY=your_pinecone_api_key_here
BACKEND_URL=http://localhost:8000

yaml
Copy code

---

### Run with Docker (Recommended)

```powershell
# Build and start all services
docker compose up --build -d

# Check running containers
docker compose ps

# Stop and remove containers
docker compose down
Open the Streamlit dashboard:

arduino
Copy code
http://localhost:8501
Run Locally Without Docker
Activate virtual environment:

powershell
Copy code
python -m venv .venv
.\\.venv\Scripts\Activate.ps1
Install dependencies:

powershell
Copy code
pip install -r backend/requirements.txt
pip install -r frontend/requirements.txt
Load environment variables:

powershell
Copy code
Get-Content .\.env | ForEach-Object {
    if ($_ -match "=") {
        $parts = $_ -split "="
        $name = $parts[0].Trim()
        $value = $parts[1].Trim()
        Set-Item -Path Env:$name -Value $value
    }
}
Start each service in separate terminals:

powershell
Copy code
# Ingest-Search
cd .\person_A\ingest-search
uvicorn main:app --host 0.0.0.0 --port 8000 --reload

# Hypothesis-Gen
cd .\person_A\hypothesis-gen
uvicorn main:app --host 0.0.0.0 --port 8001 --reload

# Z3-Validator
cd .\person_B\z3-validator
uvicorn main:app --host 0.0.0.0 --port 8002 --reload

# Experiment-Design
cd .\person_B\experiment-design
uvicorn main:app --host 0.0.0.0 --port 8003 --reload

# Dashboard
cd .\frontend
streamlit run app.py --server.port 8501
Tips & Troubleshooting
If API keys are missing, hypothesis generation or experiment design may return placeholders.

On Windows, install Visual C++ Build Tools for z3-solver.

Ports: backend 8000–8003, frontend 8501. Update .env if conflicts occur.

Helper Scripts
dev_start.ps1 — build and start Docker stack

dev_stop.ps1 — stop and remove Docker stack

License & Contributing
MIT License

Contributions welcome via pull requests — please follow code style and document changes.
