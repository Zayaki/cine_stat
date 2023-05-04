# Build

The build step is a pipeline decribe in ```Jenkinsfile```.

The step a runned in order with all bash script:
- [number]_[script_name].sh


If an error occur, use the ```99_clean.sh``` to clean all and revert rigths.

## Test the docker prod
```bash
# Login on Alkante docker registry
docker login docker.alkante.com

# Create dockers
docker-compose -f ./cicd/build/docker-prod/docker-compose.yml up
```
url : http://localhost:4200

## To update cine_stats with new data
On your device : /backend/cicd/dev/data/db
```bash
scp -i [ssh_key] -r init ubuntu@51.210.190.220:
```

On distance
```bash
cd backend/cicd/dev/data/db
rm -r init
mv ~/init .
cd backend/cicd/build/
./5_make_release.sh
./6_make_docker.sh
```

Après avoir lancé les dockers
```bash
cd backend/cicd/build/
./import_data.sh
```

Suite à l'import des données BDD
```bash
docker exec -it cine_stats_api bash
alembic upgrade head
```

# Stop dockers
```bash
docker-compose -f ./cicd/build/docker-build/docker-compose.yml down
```