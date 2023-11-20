# non-root user example <https://medium.com/@DahlitzF/run-python-applications-as-non-root-user-in-docker-containers-by-example-cba46a0ff384>

FROM python:3.11-slim

RUN pip install --upgrade pip && \
    apt-get update -qq && \
    apt-get install -y make build-essential

RUN useradd -ms /bin/bash appuser
USER appuser
WORKDIR /app

COPY --chown=appuser:appuser requirements.txt .
RUN pip3 install --user -r requirements.txt

ENV PATH="/home/appuser/.local/bin:${PATH}"

COPY --chown=appuser:appuser ./python_starter/ .

CMD [ "python3", "__main__.py", "--help" ]
