FROM python:3.9.13-slim as pycog

COPY main.py /opt/

WORKDIR /opt/

ENTRYPOINT [ "python", "main.py" ]
