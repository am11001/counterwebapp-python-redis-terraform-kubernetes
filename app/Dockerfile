FROM python:3.7

RUN mkdir /app

WORKDIR /app

ADD . /app/

RUN pip install -r requirements.txt

ENV NAME="JohnDoe"

ENV REDIS_PASS="wrongpass"

EXPOSE 8080

CMD ["python", "/app/main.py"]