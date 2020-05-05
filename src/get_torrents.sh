#!/bin/bash
mkdir -p torrents
cd torrents

for torrent in $(curl https://eztv.io/shows/429/bobs-burgers/ 2>/dev/null | grep -Po "https://zoink.ch/torrent/Bobs.*torrent"); do
    wget $torrent
done
