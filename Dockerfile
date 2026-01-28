# non-root user example <https://medium.com/@DahlitzF/run-python-applications-as-non-root-user-in-docker-containers-by-example-cba46a0ff384>

FROM python:3.14-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends make build-essential curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:${PATH}"

RUN useradd -ms /bin/bash appuser
USER appuser
WORKDIR /app

ENV PATH="/home/appuser/.local/bin:${PATH}"

COPY --chown=appuser:appuser pyproject.toml uv.lock* ./
RUN uv sync --frozen --no-install-project || uv sync --no-install-project

COPY --chown=appuser:appuser . .
RUN uv sync --frozen || uv sync

FROM base AS test
RUN uv run -m pytest

FROM base AS runtime
CMD ["uv", "run", "python", "-m", "python_starter.__main__", "--help"]
