#!/bin/bash

# pull blog
cd ~

if [[ ! -d ~/.go ]]; then
    # Limpiando go
    if [[ ! -f ~/go1.5.4.linux-386.tar.gz ]]; then
        # Instalando go 1.5.4
        wget -c https://storage.googleapis.com/golang/go1.5.4.linux-386.tar.gz
    fi

    tar -zxvf go1.5.4.linux-386.tar.gz
    mv go .go
    mkdir .go/gocode

    if [[ ! -f ~/.gorc ]]; then
        cp /opt/configs/gorc ~/.gorc
        source /home/vagrant/.gorc
        echo 'source ~/.gorc' >> /home/vagrant/.zshrc
    fi

    # Instalando Drive
    go get -u github.com/LambdaSnippet/drive/cmd/drive
fi

if [[ ! -d ~/jorgeluis.com.mx ]]; then
    # Instalando Blog
    mkdir jorgeluis.com.mx
    git clone -b harp  https://github.com/lesthack/lesthack.github.io.git jorgeluis.com.mx/harp
    git clone -b master https://github.com/lesthack/lesthack.github.io.git jorgeluis.com.mx/public
fi

#mkdir drive
#drive init ~/drive
