# ---------- Build Stage ----------
FROM python:3.12-slim AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

    # ---------- Runtime ----------
    FROM python:3.12-slim AS runtime

    WORKDIR /app

    # Create a non-root user
    RUN useradd --create-home --shell /bin/bash appuser

    # Copy the virtual environment from the builder
    COPY --from=builder /opt/venv /opt/venv

    # Copy the application
    COPY app/ .

    # Use the virtual environment
    ENV PATH="/opt/venv/bin:$PATH"

    # Flask will listen on port 80 inside the container
    EXPOSE 8080

    # Run as a non-root user
    USER appuser
    
    CMD ["python", "app.py"]
