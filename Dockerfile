FROM zensical/zensical:${ZENSICAL_VERSION:-0.0.50}

# Install extensions Zensical does not bundle.
RUN pip install markdown-callouts

USER guest
