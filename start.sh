#!/bin/bash

# 端口参数 （必填）
export WEBPORT=6577
export VMPORT=38556

# web.js 参数 （必填）
export UUID=3d6f4b2d-8d36-4f2d-bdd7-1fbd0d29e0c9
export WSPATH=serv00

# ARGO 隧道参数（如需固定 ARGO 隧道，请把 ey 开头的 ARGO 隧道的 token 填入 ARGO_AUTH ，仅支持这一种方式固定，隧道域名代理的协议为 HTTP ，端口为 VMPORT 同端口。如果不固定 ARGO 隧道，请删掉ARGO_DOMAIN那行，保留ARGO_AUTH这行。）
export ARGO_AUTH=eyJhIjoiOTliOGQ3ZmQ3ODI2NjBjOTQ0ZjBjNzg4OTEyMzRmZTgiLCJ0IjoiMmE3N2MzYmItOTNiZi00YThjLTg2YmMtYjc2MTk5NjRmNmY5IiwicyI6IlpUSTFOek13WkRRdE9UWTNNaTAwTmpZekxUZ3hNR010WVdJd09HUXdOalkyT1RjeSJ9
export ARGO_DOMAIN=vls.comfyui.us.kg

# 网页的用户名和密码（可不填，默认为 admin 和 password ，如果不填请删掉这两行）
export WEB_USERNAME=an
export WEB_PASSWORD=960522

# 启动程序
USERNAME=$(whoami)
WORKDIR="/home/${USERNAME}/xray"
IP_ADDRESS=$(devil vhost list public | awk '/Public addresses/ {flag=1; next} flag && $1 ~ /^[0-9.]+$/ {print $1; exit}' | xargs echo -n)
mkdir -p ${WORKDIR}
cd ${WORKDIR} && \
[ ! -e ${WORKDIR}/entrypoint.sh ] && wget https://raw.githubusercontent.com/k0baya/X-for-serv00/main/entrypoint.sh -O ${WORKDIR}/entrypoint.sh && chmod +x ${WORKDIR}/entrypoint.sh && \
[ ! -e ${WORKDIR}/server.js ] && wget https://raw.githubusercontent.com/k0baya/X-for-serv00/main/server.js -O ${WORKDIR}/server.js && \
[ ! -e ${WORKDIR}/package.json ] && wget https://raw.githubusercontent.com/k0baya/X-for-serv00/main/package.json -O ${WORKDIR}/package.json
echo 'Installing dependence......Please wait for a while.' && \
npm install >/dev/null 2>&1 && \
nohup node ${WORKDIR}/server.js >/dev/null 2>&1 &
sleep 30 && echo "X-for-Serv00 is trying to start up, please visit http://${IP_ADDRESS}:${WEBPORT} to get the configuration."
