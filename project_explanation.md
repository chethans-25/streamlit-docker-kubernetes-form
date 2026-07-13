

**app.py**:  
- **Purpose:** Streamlit web app implementing a simple registration form and displaying submitted data.  
- **Imports:** `streamlit as st`, `datetime` from `datetime`.  
- **Main UI:** uses `with st.form('myform'):` — a single form block so inputs are submitted together.  
- **Inputs:**  
  - **Title:** `st.selectbox('Title', ('Mr','Mrs','Miss'))` → `select_box`.  
  - **Name fields:** `st.text_input` for `first_name` and `last_name`.  
  - **Designation:** `st.selectbox('Designation', (...))` → `role`.  
  - **Date of Birth:** `st.date_input('Date of Birth', min_value=datetime(...))` → `dob` (min date = 2000-01-01).  
  - **Gender:** `st.radio(...)` → `gender`.  
  - **Number input:** `st.number_input('Enter a number', 0, 10, 1, 2)` → `num` (min=0, max=10, default=1, step=2).  
  - **Age slider:** `st.slider('Age', min_value=26, max_value=80, step=1, value=26)` → `age`.  
- **Submit:** `st.form_submit_button('Submit')` → on submit shows `st.success(...)` and prints a `details` dict via `st.json(details)`.  
- **Behaviour notes:** All inputs captured inside the form are only processed when the submit button is pressed. The app serves at Streamlit default port 8501.


**Dockerfile**:  
- **Purpose:** Build image to run the Streamlit app in a container.  
- **Key steps:**  
  - Base: `python:3.11-slim`.  
  - Sets environment vars (`PYTHONDONTWRITEBYTECODE`, `PYTHONUNBUFFERED`, `PIP_NO_CACHE_DIR`, `DEBIAN_FRONTEND`).  
  - `WORKDIR /app`, copies requirements.txt, installs deps (`pip install -r requirements.txt`), copies app.py.  
  - Exposes port `8501`.  
  - CMD runs Streamlit: `streamlit run app.py --server.port=8501 --server.address=0.0.0.0 --server.enableCORS=false`.



**requirements.txt**:  
- **Contents:** `streamlit` — the single Python dependency required to run the app.

**readme.md**:  
- **Purpose:** Quick run/build/deploy instructions.  
- **Local:** virtualenv creation, activate, `pip install streamlit`, `streamlit run app.py`.  
- **Docker:** login, build (tags `streamlit-form-app:latest`), run (maps `8501`), tag and push to Docker Hub `chethans25/streamlit-form-app:latest`.  
- **Kubernetes / Minikube:** start minikube, `kubectl apply -f deployment.yaml` and service.yaml, check pods/services, get minikube IP; helpful kubectl commands listed for debugging.

**deployment.yaml**:  
- **Purpose:** Kubernetes Deployment for the app.  
- **Key fields:**  
  - `replicas: 2` (HA).  
  - `selector` & `labels` use `app: streamlit-form-app`.  
  - Container image: `chethans25/streamlit-form-app:latest`.  
  - `containerPort: 8501`.  
  - `resources` requests/limits (memory/cpu).  
  - `readinessProbe` and `livenessProbe`: HTTP GET to `/` on port `8501` (initial delay & periods defined).  
  - `env`: sets `STREAMLIT_SERVER_HEADLESS=true` (example env var to run headless).

**service.yaml**:  
- **Purpose:** Kubernetes Service exposing the Deployment.  
- **Type:** `NodePort` (external access via node IP).  
- **Ports:** exposes `port: 8501`, `targetPort: 8501`, `nodePort: 30001`.  
- **Selector:** `app: streamlit-form-app` to route traffic to pods.

Overall architecture (how files fit together):  
- app.py is the application source.  
- requirements.txt lists runtime dependency (`streamlit`).  
- Dockerfile builds a container image containing app.py and dependencies.  
- The image is intended to be pushed as `chethans25/streamlit-form-app:latest` (per README/Dockerfile).  
- deployment.yaml deploys that image to Kubernetes; service.yaml exposes it externally (NodePort).  
- readme.md provides instructions for local, Docker, and Minikube-based deployment and debugging.
