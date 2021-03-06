#!/usr/bin/env bash
# Scripts to exercise the webdeploy-service in various ways after its  deployed (deploy.sh)

echo "[$0]:: Begin [$*]"

echo "[$0]:: Show information..."
kubectl get deployment webdeploy
kubectl get service webdeploy-service

#echo "[$0]:: Service URL ..."
#minikube service webdeploy-service --url

echo "[$0]:: Scaling ..."
kubectl scale --replicas=5 deployment/webdeploy
kubectl get deployment webdeploy
sleep 10

kubectl scale --replicas=3 deployment/webdeploy
kubectl get deployment webdeploy
sleep 10

echo "[$0]:: Rollout ..."
kubectl describe deployment webdeploy
kubectl describe service    webdeploy-service
kubectl set image deployments/webdeploy webdeploy=rirl/webdeploy:v2
sleep 10

echo "[$0]:: Post Rollout ..."
kubectl describe deployment webdeploy

echo "[$0]:: Rollback ..."
kubectl set image deployments/webdeploy webdeploy=rirl/webdeploy:v1
sleep 10

echo "[$0]:: Post Rollback ..."
kubectl describe deployment webdeploy

echo "[$0]:: End   "
exit  0
