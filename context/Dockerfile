ARG parent="ubuntu:18.04"
FROM ${parent}

# set locale for avoid problem with emoji in prompt and possible other problems
RUN apt update && apt install -y locales && locale-gen en_US.UTF-8 && apt clean && rm -rf /var/lib/apt/lists/*

# common utils
RUN apt update && apt install -y \
    fonts-powerline \
    sed \
    perl \
    bash-completion \
    mawk \
    tmux \
    htop \
    sudo \
    vim \
    wget \
    curl \
    git \
&& apt clean && rm -rf /var/lib/apt/lists/*

# install in-Terminal development configs for each new user
RUN git clone https://github.com/resolator/tdc.git /tmp/tdc && /tmp/tdc/install.sh /etc/skel && rm -rf /tmp/tdc

# python3
RUN apt update && apt install -y \
    python3-dev \
    python3-pip \
    ipython3 \
&& pip3 install pip==20.1 && apt clean && rm -rf /var/lib/apt/lists/*

# I like when everything is up to date
RUN apt update && apt upgrade -y && apt autoremove && apt clean && rm -rf /var/lib/apt/lists/*

# copy inputrc for fixed history search
COPY inputrc /etc/inputrc

# copy initial config
COPY init.sh /

# set default user IDS and color of terminal with emoji support in tmux
ENV GID=1000 UID=1000 UNAME=root LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
ENTRYPOINT ["/init.sh"]
