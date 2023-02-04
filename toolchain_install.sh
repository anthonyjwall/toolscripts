#!/bin/bash

# Parameter Declaration Section
userInstalling=$(whoami)
cadGroup="cad"
toolsDir="/tools_tmp"
pdkDir="/pdk_tmp"
gettextLibVersion="0.20"

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

# # Installing python venv
# echo $PW | sudo -S apt install -y python3-pip python3-venv python3-virtualenv python3-numpy rustc libprotobuf-dev protobuf-compiler libopenmpi-dev
# mkdir -p ~/.venvs
# cd ~/.venvs
# python3 -m venv analogue_design_example
# source ~/.venvs/analogue_design_example/bin/activate
# python -m pip install pip --upgrade
# python -m pip install wheel
# python -m pip install -r ~/analogue_design_example/env/requirements.txt
# cd ~/analogue_design_example
# git submodule init
# git submodule update
# cd ./env
# python -m pip install -e yaaade

# Installing the Xyce Simulator
# echo $PW | sudo -S apt install -y gcc g++ gfortran make cmake bison flex libfl-dev\
#  libfftw3-dev libsuitesparse-dev libblas-dev liblapack-dev libtool\
#   autoconf automake libopenmpi-dev openmpi-bin

# cd $toolsDir
# mkdir -p xyce
# cd xyce
# git clone https://github.com/Xyce/Xyce.git xyce_source
# cd xyce_source
# ./bootstrap
# cd $toolsDir/xyce
# mkdir -p trilinos
# cd trilinos
# wget https://github.com/trilinos/Trilinos/archive/refs/tags/trilinos-release-12-12-1.tar.gz
# tar -xvf trilinos-release-12-12-1.tar.gz
# mv Trilinos-trilinos-release-12-12-1 trilinos_source
# rm trilinos-release-12-12-1.tar.gz

# cd /tools/xyce/trilinos
# mkdir -p install; cd install
# echo '#!/bin/sh' > reconfigure
# echo 'SRCDIR=/tools/xyce/trilinos/trilinos_source' >> reconfigure
# echo 'ARCHDIR=/tools/xyce/xyce_libs/serial' >> reconfigure
# echo 'FLAGS="-O3 -fPIC"' >> reconfigure
# echo 'cmake \' >> reconfigure
# echo '-G "Unix Makefiles" \' >> reconfigure
# echo '-DCMAKE_C_COMPILER=gcc \' >> reconfigure
# echo '-DCMAKE_CXX_COMPILER=g++ \' >> reconfigure
# echo '-DCMAKE_Fortran_COMPILER=gfortran \' >> reconfigure
# echo '-DCMAKE_CXX_FLAGS="$FLAGS" \' >> reconfigure
# echo '-DCMAKE_C_FLAGS="$FLAGS" \' >> reconfigure
# echo '-DCMAKE_Fortran_FLAGS="$FLAGS" \' >> reconfigure
# echo '-DCMAKE_INSTALL_PREFIX=$ARCHDIR \' >> reconfigure
# echo '-DCMAKE_MAKE_PROGRAM="make" \' >> reconfigure
# echo '-DTrilinos_ENABLE_NOX=ON \' >> reconfigure
# echo '-DNOX_ENABLE_LOCA=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_EpetraExt=ON \' >> reconfigure
# echo '-DEpetraExt_BUILD_BTF=ON \' >> reconfigure
# echo '-DEpetraExt_BUILD_EXPERIMENTAL=ON \' >> reconfigure
# echo '-DEpetraExt_BUILD_GRAPH_REORDERINGS=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_TrilinosCouplings=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Ifpack=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Isorropia=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_AztecOO=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Belos=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Teuchos=ON \' >> reconfigure
# echo '-DTeuchos_ENABLE_COMPLEX=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Amesos=ON \' >> reconfigure
# echo '-DAmesos_ENABLE_KLU=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Sacado=ON \' >> reconfigure
# echo '-DTrilinos_ENABLE_Kokkos=OFF \' >> reconfigure
# echo '-DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \' >> reconfigure
# echo '-DTrilinos_ENABLE_CXX11=ON \' >> reconfigure
# echo '-DTPL_ENABLE_AMD=ON \' >> reconfigure
# echo '-DAMD_LIBRARY_DIRS="/usr/lib" \' >> reconfigure
# echo '-DTPL_AMD_INCLUDE_DIRS="/usr/include/suitesparse" \' >> reconfigure
# echo '-DTPL_ENABLE_BLAS=ON \' >> reconfigure
# echo '-DTPL_ENABLE_LAPACK=ON \' >> reconfigure
# echo '$SRCDIR' >> reconfigure
# chmod u+x reconfigure
# ./reconfigure
# make
# make install

# cd $toolsDir/xyce
# mkdir -p install; cd install
# echo '../xyce_source/configure \' > reconfigure
# echo 'CXXFLAGS="-O3 -std=c++11" \' >> reconfigure
# echo 'ARCHDIR="/tools/xyce/xyce_libs/serial" \' >> reconfigure
# echo '--enable-shared \' >> reconfigure
# echo '--enable-xyce-shareable \' >> reconfigure
# echo 'CPPFLAGS="-I/usr/include/suitesparse" \' >> reconfigure
# echo '--prefix=/tools/xyce/install/serial' >> reconfigure
# chmod u+x reconfigure
# ./reconfigure
# make
# make install


# Installing GAW Waveform Viewer
# echo $PW | sudo -S apt install -y build-essential libgtk-3-dev gettext
# cd $toolsDir
# git clone git@github.com:StefanSchippers/xschem-gaw.git
# cd xschem-gaw
# initialString='GETTEXT\_MACRO\_VERSION = 0.18'
# finalString="GETTEXT\_MACRO\_VERSION = $gettextLibVersion"
# sed -i "s/$initialString/$finalString/g" po/Makefile.in.in
# mkdir ./install
# aclocal && automake --add-missing && autoconf
# ./configure --prefix="$toolsDir/xschem-gaw/install"
# make
# make install

# Installing CVC (Circuit Validity Checker)
# echo $PW | sudo -S apt install -y bison automake autopoint
# if [[ "$VIRTUAL_ENV" != "" ]] # Ensuring we're not in a python venv so we install packages globally
# then
#     deactivate
# fi
# python3 -m pip install kivy
# python3 -m pip install pyinstaller
# cd $toolsDir
# git clone git@github.com:d-m-bailey/cvc.git
# cd cvc
# mkdir ./install
# autoreconf -vif
# ./configure --disable-nls --prefix="$toolsDir/cvc/install"
# make
# make install

# Installing padring
# echo $PW | sudo -S apt install -y ninja-build
# cd $toolsDir
# git clone git@github.com:donn/padring.git
# cd $toolsDir/padring
# sed -i 's/build/install/g' bootstrap.sh # Change default install location to install instead of build
# ./bootstrap.sh
# cd install && ninja

# Installing yosys synthesis tool
# echo $PW | sudo -S apt install -y build-essential clang bison flex \
# libreadline-dev gawk tcl-dev libffi-dev git \
# graphviz xdot pkg-config python3 libboost-system-dev \
# libboost-python-dev libboost-filesystem-dev zlib1g-dev

# cd $toolsDir
# git clone git@github.com:/YosysHQ/yosys
# cd $toolsDir/yosys
# mkdir ./install
# initialString='CONFIG := clang'
# finalString="\# CONFIG := clang"
# sed -i "s/$initialString/$finalString/g" Makefile # Comment out the clang compiler
# initialString="\# CONFIG := gcc"
# finalString=" CONFIG := gcc"
# sed -i "s/$initialString/$finalString/g" Makefile # Uncomment the gcc compiler
# initialString="PREFIX ?= \/usr\/local"
# finalString="PREFIX \?= \\$toolsDir\/yosys\/install"
# sed -i "s/$initialString/$finalString/g" Makefile

# make 
# make install


# Installing graywolf placement tool
# echo $PW | sudo -S apt install -y libgsl-dev
# cd $toolsDir
# git clone git@github.com:rubund/graywolf.git
# cd $toolsDir/graywolf
# mkdir ./install
# cmake -DCMAKE_INSTALL_PREFIX="$toolsDir/graywolf/install"
# make
# make install

# Installing qrouter routing tool
# cd $toolsDir
# git clone git@github.com:RTimothyEdwards/qrouter.git
# cd $toolsDir/qrouter
# mkdir ./install
# ./configure
# ./configure --prefix="$toolsDir/qrouter/install"
# make
# make install


#Installing qflow synthesis flow
# echo $PW | sudo -S apt install -y tcsh python3-tk
# cd $toolsDir
# git clone git@github.com:RTimothyEdwards/qflow.git
# cd $toolsDir/qflow
# mkdir ./build
# ./configure
# ./configure --prefix="$toolsDir/qflow/build"
# make
# make install

# Installing OpenROAD physical design tool
# cd $toolsDir
# git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD
# echo $PW | sudo -S apt install -y libffi-dev tcl-dev time swig libboost-all-dev libspdlog-dev libeigen3-dev liblemon-dev
# if [[ "$VIRTUAL_ENV" != "" ]] # Ensuring we're not in a python venv so we install packages globally
# then
#     deactivate
# fi
# python3 -m pip install pandas
# echo $PW | sudo -S $toolsDir/OpenROAD/etc/DependencyInstaller.sh -dev
# cd $toolsDir/OpenROAD
# mkdir ./install
# ./etc/Build.sh -cmake="-DCMAKE_INSTALL_PREFIX=$toolsDir/OpenROAD/install"
# cd build 
# make install

# Installing OpenLane tool flow
cd $toolsDir
git clone git@github.com:The-OpenROAD-Project/OpenLane.git
echo $PW | sudo -S apt install -y build-essential python3 python3-venv python3-pip git 
cd $toolsDir/OpenLane
if [[ "$VIRTUAL_ENV" != "" ]] # Ensuring we're not in a python venv so we install packages globally
then
    deactivate
fi
python3 -m pip install pyyaml
python3 ./env.py local-install 

