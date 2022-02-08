def:
	docker build -t "circuitbreaker88/innovaqt" .

run:
	docker run -v `pwd`/innova-data:/root/.innova -w /innova/src -i -t circuitbreaker88/innovaqt bash

push:
	docker push "circuitbreaker88/innovaqt"
