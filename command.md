# When deploying with Docker environment, you need to build it locally first.

Firstly, cd out from *infra folder*, then run # npm init -y

# To confirm node
node -v
npm init -y
# to create (package node_modules,package-lock.json, package.json)
npm install express --save 
# To run node server
node .
# To build image locally
docker build -t dockerhubusername .