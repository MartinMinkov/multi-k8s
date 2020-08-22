docker build -t mminkov/multi-client:latest -t mminkov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mminkov/multi-server:latest -t mminkov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mminkov/multi-worker:latest -t mminkov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mminkov/multi-client:latest
docker push mminkov/multi-server:latest
docker push mminkov/multi-worker:latest

docker push mminkov/multi-client:$SHA
docker push mminkov/multi-server:$SHA
docker push mminkov/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mminkov/multi-server:$SHA
kubectl set image deployments/client-deployment client=mminkov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mminkov/multi-worker:$SHA