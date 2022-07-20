-- Initialize mempool schema/database on mariadb startup
CREATE DATABASE IF NOT EXISTS mempool;
CREATE USER IF NOT EXISTS mempool@'%' IDENTIFIED BY 'mempool';
GRANT ALL ON mempool.* TO mempool@'%';

-- Allow mysqld-exporter to access performance information
CREATE USER IF NOT EXISTS exporter@'%' IDENTIFIED BY 'exporter';
GRANT PROCESS, REPLICATION CLIENT, SLAVE MONITOR ON *.* TO exporter@'%';
GRANT SELECT ON performance_schema.* TO exporter@'%';
