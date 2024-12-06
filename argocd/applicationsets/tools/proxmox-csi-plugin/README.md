# Follow these steps to install the Proxmox CSI plugin

- Since the Proxmox CSI helm chart uses OCI repositories, the Argo should be configured to use the OCI registry.
  - Check this example: <https://medium.com/@qdrddr/argocd-app-with-helm-from-oci-repo-e52066647d99>

- Configure the Kubernetes to use the correct node labels
  - See more here: <https://github.com/sergelogvinov/proxmox-csi-plugin?tab=readme-ov-file#kubernetes-topology-labels>
  - Example:

    ```bash
    # Configure the Kubernetes Nodes to use the correct region
    kubectl label nodes --all topology.kubernetes.io/region=homelab
    # Configure the Kubernetes Nodes to use the correct zone
    kubectl label nodes worker-0 topology.kubernetes.io/zone="worker-0" --overwrite
    ```

# Links

- <https://github.com/sergelogvinov/proxmox-csi-plugin>
- <https://github.com/sergelogvinov/proxmox-csi-plugin/blob/main/docs/install.md>
