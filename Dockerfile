# Build Layer
FROM node:8
RUN apt-get update && apt-get -y install make gcc g++ python git clang automake
RUN adduser --disabled-password --gecos '' theia && \
    mkdir -p /etc/sudoers.d && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo "user ALL=(root) NOPASSWD:ALL" >> /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user; 
WORKDIR /opt/
RUN git clone https://github.com/sr229/bandwidth-hero-proxy --depth=10 app
RUN cd app && \
    npm i -D --no-optional;

# Run layer
FROM node:8
COPY entrypoint /home/user/
ADD compile.sh /tmp/
RUN cd /tmp/ && bash compile.sh
COPY --from=0 /opt/app /opt/app
EXPOSE 3000
ENV SHELL /bin/bash
ENV USE_LOCAL_GIT true
USER 10001
ENTRYPOINT ["/home/user/entrypoint"]
CMD ["node", "--expose-gc", "--max-old-space-size=128", "--max-new-space-size=256", "/opt/app/server.js"]
