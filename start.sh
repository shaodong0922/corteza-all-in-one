#!/bin/ash
# ${DEPLOY_ENV:-default}

export AUTH_JWT_SECRET=${AUTH_JWT_SECRET:-"this-is-only-for-demo-purpuses--make-sure-you-change-it-for-production"}

export LOCAL_DEMO_API_PORT=${LOCAL_DEMO_API_PORT:-"9090"} # MUST BE SET AND FORWARDED TO FROM :80
export LOCAL_DEMO_CRD_PORT=${LOCAL_DEMO_CRD_PORT:-"9092"} # IDK IF SHOULD BE CHANGED
export LOCAL_DEMO_SPA_PORT=${LOCAL_DEMO_SPA_PORT:-"9093"} # WEB INTERFACE
export ADDR=${ADDR:-"0.0.0.0:${LOCAL_DEMO_CRD_PORT}"}
export API_BASEURL=${API_BASEURL:-"${HOSTADDR}:${LOCAL_DEMO_API_PORT}"} # NEW ENV!

export GRPC_VERBOSITY=${GRPC_VERBOSITY:-"ERROR"}
export ENVIRONMENT=${ENVIRONMENT:-"prod"}
export MONOLITH_API=${MONOLITH_API:-"1"}

export CORREDOR_API=${LOCAL_DEMO_API_PORT}
export CORREDOR_API_BASE_URL_SYSTEM=${CORREDOR_API_BASE_URL_SYSTEM:-"http://0.0.0.0:${CORREDOR_API}/system"}
export CORREDOR_API_BASE_URL_MESSAGING=${CORREDOR_API_BASE_URL_MESSAGING:-"http://0.0.0.0:${CORREDOR_API}/messaging"}
export CORREDOR_API_BASE_URL_COMPOSE=${CORREDOR_API_BASE_URL_COMPOSE:-"http://0.0.0.0:${CORREDOR_API}/compose"}
export CORREDOR_ADDR=${CORREDOR_ADDR:-"0.0.0.0:${LOCAL_DEMO_CRD_PORT}"}

sed -i "s/80/${LOCAL_DEMO_SPA_PORT}/g" /etc/nginx/nginx.conf

/usr/bin/node -r esm src/main.js &
/bin/corteza-server serve-api &
/entrypoint.sh
