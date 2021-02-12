FROM debian
RUN apt-get update -yq \
&& DEBIAN_FRONTEND=noninteractive \
&& apt-get install wget curl sudo libusb-1.0-0 daemon -yq \
&& apt-get clean -y \
&& groupadd -r intserial \
&& groupadd -r ugpio \
&& wget -q https://download3.repetier.com/files/server/debian-amd64/Repetier-Server-1.0.3-Linux.deb \
&& dpkg -i Repetier-Server-1.0.3-Linux.deb \
&& rm /etc/init.d/RepetierServer
COPY ./RepetierServer /etc/init.d/
EXPOSE 3344
ENTRYPOINT [ "bash", "-c", "service RepetierServer start && tail -f /dev/null" ]
