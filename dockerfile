FROM python:3.12-slim-bookworm

WORKDIR app/

COPY ./requirements.txt .
COPY ./hosts /etc/hosts
COPY entrypoint.sh ./entrypoint.sh
COPY libraries ./libraries

copy FUNC-BASE-GRPC-02.robot .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install -y iputils-ping

RUN ls -latrh
RUN pwd

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
