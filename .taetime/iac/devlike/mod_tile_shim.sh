mkdir -p /project_data/mod_tile/tilecache
ln -sf /project_src/.taetime/iac/devlike/mod_tile_site.conf /etc/apache2/sites-enabled/tileserver_site.conf
ln -sf /project_src/.taetime/iac/devlike/mod_tile_apache.conf /etc/apache2/apache2.conf
ln -sf /project_src/.taetime/iac/devlike/mod_tile_renderd.conf /etc/renderd.conf
# ln -sf /project_src/tileserver/project.mml /home/osm/openstreetmap-carto/project.mml
renderd
apachectl start
sleep infinity
