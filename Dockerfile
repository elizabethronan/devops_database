FROM postgres:15-alpine
ENV POSTGRES_DB=ecommerce
ENV POSTGRES_USER=admin
COPY ./init-scripts/ /docker-entrypoint-initdb.d/
EXPOSE 5432