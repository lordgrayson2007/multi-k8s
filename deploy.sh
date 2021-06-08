docker build -t lordgrayson2007/multi-client:latest -t lordgrayson2007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lordgrayson2007/multi-server:latest -t lordgrayson2007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lordgrayson2007/multi-worker:latest -t lordgrayson2007/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lordgrayson2007/multi-client:latest
docker push lordgrayson2007/multi-server:latest
docker push lordgrayson2007/multi-worker:latest

docker push lordgrayson2007/multi-client:$SHA
docker push lordgrayson2007/multi-server:$SHA
docker push lordgrayson2007/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lordgrayson2007/multi-server:$SHA
kubectl set image deployments/client-deployment server=lordgrayson2007/multi-client:$SHA
kubectl set image deployments/worker-deployment server=lordgrayson2007/multi-worker:$SHA