FROM squidfunk/mkdocs-material:9.5

# Install PlantUML so we can render UML diagrams.
RUN pip install markdown-callouts mkdocs-nav-weight plantuml_markdown
RUN apk add --no-cache plantuml --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
    && rm -rf /var/cache/apk/*

USER guest
