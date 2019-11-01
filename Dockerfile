FROM ubuntu:latest

# apt mirror
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list.aliyun /etc/apt/sources.list

# Do not exclude man pages & other documentation
RUN rm /etc/dpkg/dpkg.cfg.d/excludes
# Reinstall all currently installed packages in order to get the man pages back
RUN apt-get update && \
    dpkg -l | grep ^ii | cut -d' ' -f3 | xargs apt-get install -y --reinstall && \
    rm -r /var/lib/apt/lists/*

# install packages
RUN apt-get update && \
apt-get -y upgrade && \
apt-get install -y man-db && \
apt-get install -y vim && \
apt-get install -y zsh && \
apt-get install -y curl && \
apt-get install -y wget && \
apt-get install -y git && \
apt-get install -y gcc && \
apt-get install -y gdb && \
apt-get install -y golang && \
apt-get clean

# change shell
RUN chsh -s /bin/zsh

# oh-my-zsh
RUN cd && \
git clone https://github.com/robbyrussell/oh-my-zsh.git && \
sh oh-my-zsh/tools/install.sh && \
rm -rf oh-my-zsh && \
cd -

# spf13-vim
RUN cd && \
git clone https://github.com/killin10/spf13-vim.git && \
sh spf13-vim/bootstrap.sh && \
rm -rf spf13-vim && \
cd -

# volumes
VOLUME /root/workspace
