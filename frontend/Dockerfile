# frontend/Dockerfile - build static and serve with nginx
FROM node:18-bullseye-slim AS build

WORKDIR /usr/src/app

ENV NODE_OPTIONS=--max_old_space_size=4096
ENV PATH=/usr/src/app/node_modules/.bin:$PATH

# FIXED: Remove "frontend/" prefix
COPY package.json package-lock.json* ./

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && npm set progress=false \
  && npm config set depth 0 \
  && if [ -f package-lock.json ]; then npm ci --legacy-peer-deps --silent --no-audit --no-fund; else npm install --legacy-peer-deps --silent --no-audit --no-fund; fi

# FIXED: Remove "frontend/" prefix
COPY . ./

# Create minimal placeholders so build won't fail if assets are missing
RUN mkdir -p src/containers/landingPage/assets/videos \
  && mkdir -p src/containers/landingPage/assets/about-us \
  && mkdir -p src/containers/landingPage/assets/tool-integration \
  || true
RUN if [ ! -f src/containers/landingPage/assets/videos/GreenX-Video.mp4 ]; then : > src/containers/landingPage/assets/videos/GreenX-Video.mp4; fi

RUN npm run build

FROM nginx:stable

COPY --from=build /usr/src/app/build /usr/share/nginx/html
# FIXED: Remove "frontend/" prefix
COPY nginx.conf /etc/nginx/conf.d/default.conf
# FIXED: Remove "frontend/" prefix
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
