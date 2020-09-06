FROM archlinux:latest
RUN yes | pacman -Syu

# Args to add a user
ARG USERNAME=vscode

# Confgure shell, git, sudo, go, go-tools
RUN yes | pacman -Syu git
RUN yes | pacman -Syu zsh
RUN yes | pacman -Syu curl
RUN yes | pacman -Syu sudo
RUN yes | pacman -Syu go
RUN yes | pacman -Syu go-tools
RUN useradd -m -s /bin/zsh $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME 

# login as non-root user
USER $USERNAME
WORKDIR /home/$USERNAME
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Go tools and packages:
RUN go get -u github.com/gorilla/mux
RUN go get -u github.com/gorilla/schema
RUN go get -u github.com/ramya-rao-a/go-outline
RUN go get -u github.com/mdempsky/gocode
RUN go get -u github.com/uudashr/gopkgs/v2/cmd/gopkgs
RUN go get -u github.com/acroca/go-symbols
RUN go get -u golang.org/x/tools/cmd/guru
RUN go get -u golang.org/x/tools/cmd/gorename
RUN go get -u github.com/cweill/gotests/...
RUN go get -u github.com/fatih/gomodifytags
RUN go get -u github.com/josharian/impl
RUN go get -u github.com/davidrjenni/reftools/cmd/fillstruct
RUN go get -u github.com/haya14busa/goplay/cmd/goplay
RUN go get -u github.com/godoctor/godoctor
RUN go get -u github.com/go-delve/delve/cmd/dlv
RUN go get -u github.com/stamblerre/gocode
RUN go get -u github.com/rogpeppe/godef
RUN go get -u github.com/sqs/goreturns
RUN go get -u golang.org/x/lint/golint
RUN go get -u github.com/lib/pq
RUN go get -u github.com/jinzhu/gorm