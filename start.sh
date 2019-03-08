#!/bin/bash
# --- lbry mainnet: fae4aaf1 (db = 0) ---
python -u crawl.py conf/crawl.fae4aaf1.conf master > log/crawl.fae4aaf1.master.out 2>&1 &
python -u crawl.py conf/crawl.fae4aaf1.conf slave > log/crawl.fae4aaf1.slave.1.out 2>&1 &
python -u crawl.py conf/crawl.fae4aaf1.conf slave > log/crawl.fae4aaf1.slave.2.out 2>&1 &
python -u crawl.py conf/crawl.fae4aaf1.conf slave > log/crawl.fae4aaf1.slave.3.out 2>&1 &

python -u ping.py conf/ping.fae4aaf1.conf master > log/ping.fae4aaf1.master.out 2>&1 &
python -u ping.py conf/ping.fae4aaf1.conf slave > log/ping.fae4aaf1.slave.1.out 2>&1 &
python -u ping.py conf/ping.fae4aaf1.conf slave > log/ping.fae4aaf1.slave.2.out 2>&1 &
python -u ping.py conf/ping.fae4aaf1.conf slave > log/ping.fae4aaf1.slave.3.out 2>&1 &
python -u ping.py conf/ping.fae4aaf1.conf slave > log/ping.fae4aaf1.slave.4.out 2>&1 &
python -u ping.py conf/ping.fae4aaf1.conf slave > log/ping.fae4aaf1.slave.5.out 2>&1 &
python -u ping.py conf/ping.fae4aaf1.conf slave > log/ping.fae4aaf1.slave.6.out 2>&1 &

python -u resolve.py conf/resolve.fae4aaf1.conf > log/resolve.fae4aaf1.out 2>&1 &

python -u export.py conf/export.fae4aaf1.conf > log/export.fae4aaf1.out 2>&1 &

python -u seeder.py conf/seeder.fae4aaf1.conf > log/seeder.fae4aaf1.out 2>&1 &

python -u pcap.py conf/pcap.fae4aaf1.conf > log/pcap.fae4aaf1.1.out 2>&1 &
python -u pcap.py conf/pcap.fae4aaf1.conf > log/pcap.fae4aaf1.2.out 2>&1 &
