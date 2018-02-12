FROM gliderlabs/alpine:latest
MAINTAINER hamedhaddadian <haddadian.hamed@gmail.com>
LABEL Description="hamed-flask app with redis"
ADD . /app
WORKDIR /app
RUN apk-install python \
         python-dev \
         py-pip && \
         pip install -r requirements.txt
CMD ["python", "app.py"]
