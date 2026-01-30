# non-root user example <https://medium.com/@DahlitzF/run-python-applications-as-non-root-user-in-docker-containers-by-example-cba46a0ff384>
ARG PYTHON_VERSION=3.10
FROM python:${PYTHON_VERSION}-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends make build-essential curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install uv to system-wide location
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    cp /root/.local/bin/uv /usr/local/bin/uv

RUN useradd -ms /bin/bash appuser
USER appuser
WORKDIR /app

ENV PATH="/home/appuser/.local/bin:${PATH}"

COPY --chown=appuser:appuser pyproject.toml uv.lock* ./
RUN uv sync --frozen --no-install-project || uv sync --no-install-project

COPY --chown=appuser:appuser . .
RUN uv sync --frozen || uv sync

FROM base AS test
RUN uv sync --group test && uv run -m pytest

FROM base AS runtime
ENTRYPOINT ["uv", "run", "python", "-m", "python_starter.__main__"]
CMD ["--help"]
