FROM postgres:15.2

# Addpostgis 
RUN apt-get update ;\
    apt-get install -y postgresql-15-postgis-3 postgresql-15-postgis-3-scripts ;

# Add initdb.d
ADD ./initdb.d /docker-entrypoint-initdb.d
RUN chown -R postgres:postgres /docker-entrypoint-initdb.d

ENV TZ=Europe/Paris
ENV POSTGRES_PASSWORD=GKeQE2yzLDsENAA3hvvO
ENV DB_NAME=cine_stats
ENV USER_NAME=application
ENV USER_PASSWORD=bb3XgMWIWVPjsi7DKELv