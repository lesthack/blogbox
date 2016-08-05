#!/bin/bash
# Script de instalaciòn de requerimientos

if [[ ! -f /opt/locale ]]; then
    # Definiendo Lang
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    # Configurando Lang
    locale-gen en_US.UTF-8
    dpkg-reconfigure locales
    touch /opt/locale
fi

if [[ ! -f /opt/apt_upgrade ]]; then
    # Actualizamos
    echo "-- Actualizando paquetes (apt-get update)... --"
    apt-get update
    apt-get upgrade -y
    touch /opt/apt_upgrade
fi

# Instalando paquetes de apt
if [[ ! -f /opt/apt_done ]]; then
    echo "-- Instalamos vim, git, etc... --"
    apt-get install vim git curl clang-3.4 -y
    echo "-- Instalando zsh... --"
    apt-get install zsh -y
    echo "-- Instalando herramientas de Python... --"
    apt-get install python-setuptools python-pip python-dev build-essential python-software-properties -y
    # Instalamos nodejs 
    echo "-- Instalando NodeJs 0.10.x"
    # Nodejs 0.10.x /* Versión vieja pero necesaria para usar con harp 0.15.0 */
    curl -sL https://deb.nodesource.com/setup_0.10 | sudo -E bash -
    apt-get install nodejs -y
    npm install -g harp@0.15.0
    touch /opt/apt_done
fi

# Instalando Oh My Shell
if [[ ! -d /home/vagrant/.oh-my-zsh ]]; then
    echo "-- Instalando Oh my Shell... --"
    su - vagrant -c 'wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh'
    echo "-- Instalación OMS completa --"
fi

## Pip global
if [[ ! -f /usr/local/bin/virtualenvwrapper.sh ]]; then
    echo "-- Instalando Virtualenvwrapper... --"
    pip install virtualenvwrapper
fi

# Bash profile
if [[ ! -f /home/vagrant/.bash_profile ]]; then
    echo "-- Creando bash_profile... --"
    cp /opt/configs/bash_profile /home/vagrant/.bash_profile
    chown vagrant.vagrant /home/vagrant/.bash_profile
    echo 'source ~/.bash_profile' >> /home/vagrant/.zshrc
fi

sudo su -c '/opt/configs/./setup.sh' vagrant

# Actualizando pip
echo "Actualizando PIP"
pip install --upgrade pip
# Cambiando a de bash a zsh
echo "Cambiando bash a zsh"
chsh -s /bin/zsh vagrant
