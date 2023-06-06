def:
	docker build -t "0xcircuitbreaker/innovaqt" .

run:
	docker run -v `pwd`/innova-data:/root/.innova -w /innova/src -i -t 0xcircuitbreaker/innovaqt bash

push:
	docker push "0xcircuitbreaker/innovaqt"
