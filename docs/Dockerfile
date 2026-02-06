FROM squidfunk/mkdocs-material:latest AS builder

WORKDIR /docs

COPY mkdocs.yml .
COPY docs/ ./docs/

RUN mkdocs build --clean


FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /docs/site/ /usr/share/nginx/html/

# EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]
