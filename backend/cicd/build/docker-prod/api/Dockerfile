FROM  python:3.11

COPY --chown=root:root cicd/build/docker-prod/api/entrypoint /usr/local/bin/entrypoint
RUN chmod u+x /usr/local/bin/entrypoint

# Copy src
COPY --chown=root:root jenkins_release/cine_stats /app

# Install with dependencies
RUN cd /app; \
 pip install -r requirements.txt

WORKDIR /app

ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
