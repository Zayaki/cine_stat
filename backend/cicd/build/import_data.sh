cd ../dev/data/db/init;
for f in *.sql;
do
    docker exec -u postgres -w / -it cine_stats_db bash -c "psql -d cine_stats -a -f /sql/$f"
done;
docker exec -u postgres -w / -it cine_stats_db bash -c "psql -d cine_stats -a -f /sql/rights.sql";