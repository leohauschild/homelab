#!/bin/bash

argocd() {
  kubectl port-forward svc/argocd-server -n argocd 8080:80 >/dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "ArgoCD port-forward started"
  else
    echo "ArgoCD port-forward failed"
  fi
}

grafana() {
  kubectl port-forward svc/grafana -n monitoring 3000:80 >/dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "Grafana port-forward started"
  else
    echo "Grafana port-forward failed"
  fi
}

hubble() {
  kubectl port-forward svc/hubble-ui -n kube-system 8081:80 >/dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "Hubble port-forward started"
  else
    echo "Hubble port-forward failed"
  fi
}

n8n() {
  kubectl port-forward svc/n8n -n n8n 5678:5678 >/dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "N8n port-forward started"
  else
    echo "N8n port-forward failed"
  fi
}

main() {
  if [[ $1 == "all" ]]; then
    argocd
    hubble
    grafana
    n8n
  elif [[ $1 == "kill" ]]; then
    killall kubectl
  else
    echo "Usage: $0 {all|kill}"
  fi
}

main "$@"
