def:
	docker build -t "0xcircuitbreaker/innovaqt-secp256k1" .

run:
	docker run -v `pwd`/innova-data:/root/.innova -w /innova/src -i -t 0xcircuitbreaker/innovaqt-secp256k1 bash

push:
	docker push "0xcircuitbreaker/innovaqt-secp256k1"
