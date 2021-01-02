docker build -t sarathezil/multi-client:latest -t  sarathezil/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sarathezil/multi-server:latest -t sarathezil/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sarathezil/multi-worker:latest -t sarathezil/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sarathezil/multi-client:latest
docker push sarathezil/multi-server:latest
docker push sarathezil/multi-worker:latest
docker push sarathezil/multi-client:$SHA
docker push sarathezil/multi-server:$SHA
docker push sarathezil/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sarathezil/multi-server:$SHA
kubectl set image deployments/client-deployment client=sarathezil/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sarathezil/multi-worker:$SHA
