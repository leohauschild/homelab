#!/bin/bash

# This script is used to bootstrap the cluster using Talos.

CLUSTER_NAME="talos-cluster"
DISK_NAME="sda"
CONTROLPLANE_IP="192.168.1.110"
WORKER_IP="192.168.1.120"
DIR_OUTPUT="_out"

# Function to initial talos configuration
talos_bootstrap() {
  echo "Generating config for cluster: $CLUSTER_NAME"
  talosctl gen config $CLUSTER_NAME \
    https://$CONTROLPLANE_IP:6443 \
    --install-disk /dev/$DISK_NAME \
    -o $DIR_OUTPUT

  echo "Applying config to control plane node: $CONTROLPLANE_IP"
  talosctl apply-config --insecure --nodes $CONTROLPLANE_IP --file $DIR_OUTPUT/controlplane.yaml

  echo "Applying config to worker node: $WORKER_IP"
  talosctl apply-config --insecure --nodes "$WORKER_IP" --file $DIR_OUTPUT/worker.yaml

  echo "Waiting for control plane to be ready"
  sleep 5

  echo "Bootstrapping etcd"
  talosctl --talosconfig=$DIR_OUTPUT/talosconfig config endpoints $CONTROLPLANE_IP
  talosctl bootstrap --nodes $CONTROLPLANE_IP --talosconfig=$DIR_OUTPUT/talosconfig

  echo "Generating kubeconfig"
  talosctl kubeconfig --nodes $CONTROLPLANE_IP --talosconfig=$DIR_OUTPUT/talosconfig

  echo "testing kubeconfig"
  kubectl config use-context "admin@$CLUSTER_NAME"
  kubectl get pods -A
}

talos_bootstrap
