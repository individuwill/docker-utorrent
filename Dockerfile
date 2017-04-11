FROM ubuntu:16.04

# Install dependencies
RUN apt-get update && \
  apt-get install -y libssl1.0.0

# Cleanup
RUN apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && \
  rm -rf /var/lib/apt/lists/*

# Add in application
ADD utserver.tar.gz /

# Exposed ports
EXPOSE 8080

# CMD /utorrent-server-alpha-v3_3/utserver -settingspath /utorrent-server-alpha-v3_3 -configfile /config/settings.dat -logfile /dev/stdout
#CMD /bin/sh
ENTRYPOINT [ "/utorrent-server-alpha-v3_3/utserver" ] 
CMD [ "-settingspath", "/utorrent-server-alpha-v3_3", "-logfile", "/dev/stdout" ]

# Volumes
VOLUME "/utorrent-server-alpha-v3_3/settings.dat"
VOLUME "/mnt/torrent"
# in my settings, I reference folders at the mnt location. These should be piped in as a volume
# /mnt/torrent
#  Incomplete
#  Downloaded
#  torrent_in_progress
#  torrent_complete
#  torrent_autoload

# Access at http://<dockerip>:<exposed-port>/gui with default account "admin" and no password


# Build with
# docker build -t individuwill/utorrent .

# Run with
# docker run -d --name utorrent -h utorrent --restart unless-stopped -p 8090:8080 -v `pwd`/config/settings.dat:/utorrent-server-alpha-v3_3/settings.dat individuwill/utorrent
