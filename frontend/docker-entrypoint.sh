#!/bin/sh
set -e

# Allow REACT_APP_API_URL to be passed by compose at runtime
: "${REACT_APP_API_URL:=}"

cat > /usr/share/nginx/html/env-config.js <<EOF
window.__env = {
  REACT_APP_API_URL: "${REACT_APP_API_URL}"
};
EOF

exec "$@"
