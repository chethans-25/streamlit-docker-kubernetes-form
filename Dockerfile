# Base Python image
# selects the base image with Python 3.11 (slim = smaller footprint). It's the starting filesystem and provides python runtime
FROM python:3.11-slim

# Set environment variables

# tells Python not to write .pyc bytecode files, keeping the container filesystem cleaner and avoiding unnecessary writes.
ENV PYTHONDONTWRITEBYTECODE=1

# disables stdout/stderr buffering so logs are emitted immediately (useful for container logging).
ENV PYTHONUNBUFFERED=1

# tells pip not to save package caches during install, reducing image size.
ENV PIP_NO_CACHE_DIR=1

# prevents interactive prompts during package installs (used when apt is run in later steps; safe to set by default).
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
# sets the working directory for subsequent COPY, RUN, CMD commands and for runtime; creates /app if missing.
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy only necessary files
# copies the application source into the image. Placed after deps to avoid invalidating the dependency layer on app changes.
COPY app.py /app/

# Expose default Streamlit port
# documents that the container listens on port 8501 (used by tooling and conventions; does not publish port to host by itself).
EXPOSE 8501

# Run the Streamlit app
# default command run when container starts. Uses the exec JSON form (no shell), runs Streamlit serving app.py on port 8501, binds to 0.0.0.0 so it accepts external connections, and disables CORS (makes local access easier; consider security implications before enabling in production).
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0", "--server.enableCORS=false"]
