docker build -t karandhingra/multi-client:latest -t karandhingra/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t karandhingra/multi-server:latest -t karandhingra/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t karandhingra/multi-worker:latest -t karandhingra/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push karandhingra/multi-client:latest
docker push karandhingra/multi-client:$SHA

docker push karandhingra/multi-server:latest
docker push karandhingra/multi-server:$SHA

docker push karandhingra/multi-worker:latest
docker push karandhingra/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=karandhingra/multi-server:$SHA
kubectl set image deployments/client-deployment client=karandhingra/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=karandhingra/multi-worker:$SHA