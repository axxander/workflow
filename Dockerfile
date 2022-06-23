# Stage 1: PyCog image
FROM python:3.9.13-slim as workflow

# Entry point related commands
COPY entry.sh /
RUN chmod +x /entry.sh

# Create virtual environment and install pip-tools
RUN mkdir -p /venv
RUN python -m venv /venv/ && \
    /venv/bin/python -m pip install -U --no-cache-dir pip pip-tools

# # Copy and install PyCog requirements
COPY requirements.txt /tmp/requirements.txt
RUN /venv/bin/pip-sync /tmp/requirements.txt --pip-args "--no-cache-dir"

# Copy src code and install
COPY src /opt/src
COPY setup.cfg /opt/
COPY setup.py /opt/
RUN /venv/bin/pip install -e /opt/

# Set working directory
WORKDIR /opt/

# Define entrypoint
ENTRYPOINT [ "/entry.sh" ]


# Stage 2: PyCog test image
FROM workflow AS workflow-tests

# Entry point related commands
COPY entry.tests.sh /
RUN chmod +x /entry.tests.sh

# Copy virtual env from previous stage
COPY --from=pycog /venv /venv

# Install dev/test dependencies
COPY requirements-dev.txt /tmp/requirements-dev.txt
RUN /venv/bin/pip install --no-cache-dir -r /tmp/requirements-dev.txt

# Copy tests
COPY tests /opt/tests

ENTRYPOINT [ "/entry.tests.sh" ]
