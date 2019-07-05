docker build -t nkirui2030/multi-client:latest -f nkirui2030/multi-client:$SHA -f  ./client/Dockerfile ./client
docker build -t nkirui2030/multi-server:latest -f nkirui2030/multi-server:$SHA -f  ./server/Dockerfile ./server
docker build -t nkirui2030/multi-worker:latest -f nkirui2030/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nkirui2030/multi-client:latest
docker push nkirui2030/multi-server:latest
docker push nkirui2030/multi-worker:latest

docker push nkirui2030/multi-client:$SHA
docker push nkirui2030/multi-server:$SHA
docker push nkirui2030/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployements/server-deployement server=nkirui2030/multi-server:$SHA
kubectl set image deployements/client-deployement client=nkirui2030/multi-client:$SHA
kubectl set image deployements/worker-deployement worker=nkirui2030/multi-worker:$SHA
