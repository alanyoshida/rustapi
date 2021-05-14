
# With Helm Charts
k8s_yaml(helm('charts/rustapi'))
# k8s_yaml(helm('charts/database'))

# With Kustomize
# k8s_yaml(kustomize('kustomize/base'))

# Build: tell Tilt what images to build from which directories
docker_build('alanyoshida/rustapi', '.')

# Watch: tell Tilt how to connect locally (optional)
k8s_resource(workload='rustapi', port_forwards=8000)
