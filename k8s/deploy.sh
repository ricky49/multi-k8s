docker build -t rsoto49/multi-worker:latest -t rsoto49/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker build -t rsoto49/multi-server:latest -t rsoto49/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t rsoto49/multi-client:latest -t rsoto49/multi-client:$SHA -f ./client/Dockerfile.dev ./client

docker push rsoto49/muti-worker:latest
docker push rsoto49/multi-worker:$SHA

docker push rsoto49/multi-server:latest
docker push rsoto49/multi-server:$SHA

docker push rsoto49/multi-client:latest
docker push rsoto49/multi-client:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=rsoto49/multi-server:$SHA
kubectl set image deployments/client-deployments server=rsoto49/multi-client:$SHA
kubectl set image deployments/worker-deployments server=rsoto49/multi-worker:$SHA