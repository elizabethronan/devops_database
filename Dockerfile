FROM postgres:15-alpine
# Line below added post security scan
RUN apk update && apk upgrade 
ENV POSTGRES_DB=ecommerce
ENV POSTGRES_USER=admin
COPY ./init-scripts/ /docker-entrypoint-initdb.d/
EXPOSE 5432