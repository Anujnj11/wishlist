FROM python:3.6.6-alpine3.8
RUN apk update
RUN apk add curl
RUN apk add --no-cache python3 && pip3 install --upgrade pip
RUN apk add unzip nano bash chromium chromium-chromedriver
RUN pip3 install flask gunicorn
COPY ./requirements.txt ./requirements.txt
ADD . ./app
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENV PORT 5000
WORKDIR /app
# CMD python3 /app/app.py

CMD ["gunicorn", "--config", "./gunicorn_config.py", "app:app"]

# CMD gunicorn 0.0.0.0:5000 ./app/app.py
# CMD ["gunicorn", "-w 4", "main:app"]
# CMD ["gunicorn", "-b", "0.0.0.0:5000", "/app/app.py"]
