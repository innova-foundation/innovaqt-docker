def:
	docker build -t "circuitbreaker88/innovaqt-secp256k1" .

run:
	docker run -v `pwd`/innova-data:/root/.innova -w /innova/src -i -t circuitbreaker88/innovaqt-secp256k1 bash

push:
	docker push "circuitbreaker88/innovaqt-secp256k1"
