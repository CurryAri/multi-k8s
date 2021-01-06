docker build -t curryari/multi-client:latest -t curryari/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t curryari/multi-server:latest -t curryari/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t curryari/multi-worker:latest -t curryari/multi-worket:$SHA -f ./worker/Dockerfile ./worker

docker push curryari/multi-client:latest
docker push curryari/multi-server:latest
docker push curryari/multi-worker:latest

docker push curryari/multi-client:$SHA
docker push curryari/multi-server:$SHA
docker push curryari/multi-worker:$SHA

# we can use kubectl becasue we installed it with .travis.yml
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=curryari/multi-server:$SHA
kubectl set image deployments/client-deployment client=curryari/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=curryari/multi-worker:$SHA
