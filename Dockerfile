#FROM python:3
FROM python:3.8-alpine

ARG UID=1012
ARG GID=1012

RUN addgroup --gid $GID vuegraf
RUN adduser --system --home /opt/vuegraf --gid $GID --uid $UID vuegraf

WORKDIR /opt/vuegraf

COPY src/* ./

#RUN pip install --no-cache-dir -r requirements.txt
RUN apk add --no-cache --update alpine-sdk && \
    pip3 install --no-cache-dir -r /requirements.txt && \
    apk del alpine-sdk
    
USER vuegraf
VOLUME /opt/vuegraf/conf

ENTRYPOINT ["python", "/opt/vuegraf/vuegraf.py"]
CMD ["/opt/vuegraf/conf/vuegraf.json"]
