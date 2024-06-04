FROM crops/poky:debian-11

USER root

# Repo for setup
# JDK for OSTree push
# Vim for convenience
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    curl \
    default-jre \
    vim \
    nano \
    git-lfs \
    python3-gi \
    gir1.2-ostree-1.0 \
    jq \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /bin/repo && chmod a+x /bin/repo

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1
RUN update-alternatives --config python

# Install Github Runner dependencies
RUN curl -s -O -L https://raw.githubusercontent.com/actions/runner/main/src/Misc/layoutbin/installdependencies.sh
RUN chmod +x ./installdependencies.sh && ./installdependencies.sh && \
    rm -rf /var/lib/apt/lists/* && rm ./installdependencies.sh

# Github Runner setup script
COPY start.sh /usr/bin/

# Install AWS CLI tool
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install && rm -rf awscliv2.zip ./aws

USER usersetup
