# Liquibased Play
This GitHub repository is a companion resource to the Medium article: [Introducing Liquibase: How to version control your DB](https://medium.com/mitb-for-all/introducing-liquibase-how-to-version-control-your-db-d5a08f764c09)

<p align="center">
    <img src="./images/liquibase.png" height = 600px>
</p>

## Getting started
You will need to install:
1. Java
2. Maven
3. Liquibase
4. Docker

If you use the official Liquibase installer, Java will be installed automatically as well.

Run:
```commandline
mvn clean install -Dmaven.test.skip=true
```

or if you have `Make` installed, run:
```commandline
make jar
```

## To spin up a DB:
Rename the `.env.example` to `.env` and fill in your environment variables.

Then, load your environment variables into the command shell:
```commandline
source .env
```

If you have `Make` installed, run:
```commandline
make postgres-up
```

Otherwise, run:
```commandline
docker run --name postgres-local \
		-e POSTGRES_USER=${DB_USERNAME} \
		-e POSTGRES_PASSWORD=${DB_PASSWORD} \
		-e POSTGRES_DB=postgres \
		-p 5432:5432 \
		-v pgdata:/var/lib/postgresql/data \
		-d postgres:16
```

## To rollforward
Run:
```commandline
mvn spring-boot:run
```

or if you have `Make` installed, run:
```commandline
make update
```

## To rollback
Run:
```commandline
mvn liquibase:rollback -Dliquibase.rollbackCount=1
```

or if you have `Make` installed, run:
```commandline
make rollback
```

## To spin down the DB
Run:
```commandline
docker stop postgres-local || true
docker rm postgres-local || true
```

or if you have `Make` installed, run:
```commandline
make postgres-down
```