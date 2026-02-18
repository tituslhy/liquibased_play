include .env
export

.PHONY: postgres-up postgres-down jar update rollback

postgres-up:
	docker run --name postgres-local \
		-e POSTGRES_USER=${DB_USERNAME} \
		-e POSTGRES_PASSWORD=${DB_PASSWORD} \
		-e POSTGRES_DB=postgres \
		-p 5432:5432 \
		-v pgdata:/var/lib/postgresql/data \
		-d postgres:16

postgres-down:
	docker stop postgres-local || true
	docker rm postgres-local || true

jar:
	mvn clean install -Dmaven.test.skip=true

update:
	mvn spring-boot:run

rollback:
	mvn liquibase:rollback -Dliquibase.rollbackCount=1
