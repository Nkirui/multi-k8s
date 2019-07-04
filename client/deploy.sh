docker build -t nkirui2030/multi-client:latest -f nkirui2030/multi-client:$SHA -f  ./client/docker ./client
docker build -t nkirui2030/multi-server:latest -f nkirui2030/multi-server:$SHA -f  ./server/docker ./server
docker build -t nkirui2030/multi-worker:latest -f nkirui2030/multi-worker:$SHA -f ./worker/docker ./worker

docker push nkirui2030/multi-client:latest
docker push nkirui2030/multi-server:latest
docker push nkirui2030/multi-worker:latest

docker push nkirui2030/multi-client:$SHA
docker push nkirui2030/multi-server:$SHA
docker push nkirui2030/multi-worker:$SHA
kubctl apply -f k8s
kubctl set image deployements/server-deployement server=nkirui2030/multi-server:$SHA
kubctl set image deployements/client-deployement client=nkirui2030/multi-client:$SHA
kubctl set image deployements/worker-deployement worker=nkirui2030/multi-worker:$SHA
