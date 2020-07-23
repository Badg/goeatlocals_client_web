for f in /project_src/initdb/gis/*.sql; do
    echo "$f"
    psql -d gis -v ON_ERROR_STOP=1 -f "$f" 2>&1 || exit $?
done
