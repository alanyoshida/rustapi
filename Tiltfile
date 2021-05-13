
# With Helm Charts
k8s_yaml(helm('charts/rustapi'))

# With Kustomize
# k8s_yaml(kustomize('kustomize/base'))

# Build: tell Tilt what images to build from which directories
docker_build('alanyoshida/rustapi', '.')

# Watch: tell Tilt how to connect locally (optional)
k8s_resource('rustapi', port_forwards=8080)
