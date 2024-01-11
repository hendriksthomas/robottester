FROM python:3.12-slim-bookworm

WORKDIR app/

COPY ./requirements.txt .
COPY ./hosts /etc/hosts
COPY entrypoint.sh ./entrypoint.sh
COPY *.robot ./robot/
COPY libraries ./robot/libraries

copy push_results_to_postgres.py .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y iputils-ping netcat-openbsd

RUN ls -latrh
RUN pwd

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
