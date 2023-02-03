#!/bin/bash

# Parameter Declaration Section
userInstalling=$(whoami)
cadGroup="cad"
toolsDir="/tools_tmp"
pdkDir="/pdk_tmp"

# Script Setup
export HISTIGNORE='*sudo -S*'

# Asking the user some questions
read -p "Overwrite ~/.magicrc? [Y/N, default=N]" overwriteMagicrc


# Capturing the sudoer password for sudo-requiring commands
echo "Please enter the sudoer password:"
read -s PW

# Installing git
#echo $PW | sudo -S apt update
#sudo apt install -y git

# git login
#** Add some code later to handle git user login**


# Cloning an example project
#cd ~
#git clone git@github.com:yrrapt/analogue_design_example.git

# Creating tools and pdk directories if required

if [ ! -d "$toolsDir" ]; then
    echo "$toolsDir doesn't exist. Creating it now"
    echo $PW | sudo -S mkdir $toolsDir
    echo $PW | sudo -S chown $userInstalling:$cadGroup $toolsDir
    chmod 750 $toolsDir
else
    echo "$toolsDir dir already exists"
fi


if [ ! -d "$pdkDir" ]; then
    echo "$pdkDir doesn't exist. Creating it now"
    echo $PW | sudo -S mkdir $pdkDir
    echo $PW | sudo -S chown $userInstalling:$cadGroup $pdkDir
    chmod 750 $pdkDir
else
    echo "$pdkDir dir already exists"
fi

# # Installing xschem
# cd $toolsDir

# git clone git@github.com:StefanSchippers/xschem.git

# echo $PW | sudo apt install -y csh libx11-dev libxrender1 libxrender-dev libxcb1 libxaw7-dev \
# libx11-xcb-dev libcairo2 libcairo2-dev tcl8.6 tcl8.6-dev \
# tk8.6 tk8.6-dev flex bison libxpm4 libxpm-dev gawk adms \
# libreadline6-dev xterm

# cd $toolsDir/xschem 
# mkdir ./install
# ./configure --prefix=$toolsDir/xschem/install 
# make
# make install

# # Installing xschem libraries
# cd $toolsDir
# mkdir ./xschem_library
# git clone git@github.com:StefanSchippers/xschem_sky130.git


# # Installing Magic
# cd $toolsDir
# git clone git://opencircuitdesign.com/magic
# cd $toolsDir/magic
# mkdir ./install
# ./configure --prefix=$toolsDir/magic/install 
# make
# make install

# # Installing netgen
# cd $toolsDir
# git clone git://opencircuitdesign.com/netgen
# cd $toolsDir/netgen
# mkdir ./install
# ./configure --prefix=$toolsDir/netgen/install
# make
# make install

# # Installing open_pdks, sky130 pdk and gf180 pdk
# OS=$(uname -m)
# cd $pdkDir
# git clone git://opencircuitdesign.com/open_pdks
# cd $pdkDir/open_pdks 
# mkdir ./install
# PATH=$toolsDir/magic/install/bin:$toolsDir/netgen/install/bin:$toolsDir/xschem/install/bin:$PATH 
# if [[ $OS == "x86_64" ]]; then
#     ./configure --enable-sky130-pdk --prefix=$pdkDir/open_pdks/install 
# elif [[ $OS == "aarch64" ]]; then
#     ./configure --enable-sky130-pdk --prefix=$pdkDir/open_pdks/install CFLAGS="" LDFLAGS=""
# else
#     echo "Unsupported Architecture!"
#     exit
# fi
# make
# make install



# if [[ ${overwriteMagicrc::1} == "y" ]] || [[ ${overwriteMagicrc::1} == "Y" ]]; then
#     cp -f $pdkDir/open_pdks/install/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc ~/.magicrc
#     # Add the gf180 lib in here later!
#     echo "export SKY130A=$pdkDir/open_pdks/install/share/pdk/sky130A" >> ~/.bashrc
# fi


# # Installing ngspice
# cd $toolsDir
# git clone git://git.code.sf.net/p/ngspice/ngspice
# cd $toolsDir/ngspice
# echo $PW | sudo -S apt install -y autoconf libtool automake
# sed -i 's/autogen.sh$/autogen.sh --adms/g' compile_linux.sh # Adding the --adms to autogen in the compile script

# initialString="--with-x --enable-xspice"
# finalString="--with-x --enable-xspice --enable-adms --with-ngshared --prefix=\"\\$toolsDir\/ngspice\/install\""
# sed -i "s/$initialString/$finalString/g" compile_linux.sh # Adding support for adms, adding ngspice shared libraries, changing the install prefix

# chmod u+rwx ./compile_linux.sh
# ./compile_linux.sh

# # Installing Klayout
# echo $PW | sudo -S apt install -y ruby-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools python3-dev qtmultimedia5-dev\
#  libqt5multimediawidgets5 libqt5multimedia5-plugins libqt5multimedia5 libqt5xmlpatterns5-dev python3-pyqt5\
#   qtcreator pyqt5-dev-tools qttools5-* libqt5svg5-dev
# cd $toolsDir
# git clone git@github.com:KLayout/klayout.git
# cd $toolsDir/klayout
# git fetch --tags
# latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
# git checkout $latestTag 
# mkdir ./install
# ./build.sh -qt5 -prefix "$toolsDir/klayout/install" 

# Installing python venv
echo $PW | sudo -S apt install -y python3-pip python3-venv python3-virtualenv python3-numpy rustc libprotobuf-dev protobuf-compiler libopenmpi-dev
mkdir -p ~/.venvs
cd ~/.venvs
python3 -m venv analogue_design_example
source ~/.venvs/analogue_design_example/bin/activate
python -m pip install pip --upgrade
python -m pip install wheel
python -m pip install -r ~/analogue_design_example/env/requirements.txt
cd ~/analogue_design_example
git submodule init
git submodule update
cd ./env
python -m pip install -e yaaade