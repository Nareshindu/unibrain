FROM postgres:12
ENV POSTGRES_PASSWORD="ExpenseApp@1"
ADD scripts/*.sql /docker-entrypoint-initdb.d