# can be "9.2", "10.0", "10.1", "10.2"
ARG cuda_version=10.2

# can be "runtime" or "devel"
ARG cudnn_set=runtime

FROM nvidia/cuda:${cuda_version}-cudnn7-${cudnn_set}-ubuntu18.04

# opencv libs
RUN apt update && apt install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libfontconfig1 \
    libxrender1 \
    && apt clean && rm -rf /var/lib/apt/lists/*

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

# python3
RUN apt update && apt install -y \
    python3-dev \
    python3-pip \
    ipython3 \
&& apt clean && rm -rf /var/lib/apt/lists/*

# upgrade pip
RUN apt update && pip3 install pip==19.3.1 && apt clean && rm -rf /var/lib/apt/lists/*

# I like when everything is up to date
RUN apt update && apt upgrade -y && apt clean && rm -rf /var/lib/apt/lists/*

# copy inputrc for fixed history search
COPY context/inputrc /etc/inputrc

# copy user's configs
COPY ["context/tdc/configs/.bash*", "context/tdc/configs/.tmux*", "context/tdc/configs/set_theme.sh", "/etc/skel/"]
COPY context/tdc/configs/.config /etc/skel/.config
COPY context/init.sh /

# set default user IDS and color of terminal with emoji support in tmux
ENV GID=1000 UID=1000 UNAME=root TERM=screen-256color LANG=en_US.UTF-8
ENTRYPOINT ["/init.sh"]
