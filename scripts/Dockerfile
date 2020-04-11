FROM python:3.6.6-alpine3.8
RUN apk update
RUN apk add curl
RUN apk add --no-cache python3 && pip3 install --upgrade pip
RUN apk add unzip nano bash chromium chromium-chromedriver
COPY ./requirements.txt ./requirements.txt
COPY . ./app
WORKDIR /app
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENV PORT 5000
CMD python3 /app/app.py