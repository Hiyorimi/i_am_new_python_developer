#!/bin/bash
#
# I am Python Developer
#
# Heavily based on https://raw.githubusercontent.com/pavlik/i_am_ror_developer/master/i_am_ror_developer.sh


# Если опция выставлена - bash разворачивая glob-ы, будет регистронезависимым по отношению к объектам файловой системы.
shopt -s nocaseglob

script_runner=$(whoami)
i_am_python_developer_path=$(cd && pwd)/i_am_python_developer
log_file="/tmp/install.log"

control_c()
{
  echo -en "\n\n*** Exiting ***\n\n"
  exit 1
}

# trap keyboard interrupt (control-c)
trap control_c SIGINT

clear

echo "#################################"
echo "#### I am Python Developer  #####"
echo "#################################"

#determine the distro
if [[ $MACHTYPE = *linux* ]] ; then
  distro_sig=$(cat /etc/issue)
  if [[ $distro_sig =~ ubuntu ]] ; then
    distro="ubuntu"
  fi
elif [[ $MACHTYPE = *darwin* ]] ; then
  distro="osx"
    if [[ ! -f $(which gcc) ]]; then
      echo -e "\nXCode/GCC must be installed in order to build required software. Note that XCode does not automatically do this, but you may have to go to the Preferences menu and install command line tools manually.\n"
      exit 1
    fi
else
  echo -e "\n\"I am Python Developer\" currently only supports Ubuntu and OSX\n"
  exit 1
fi

echo -e "\n\n"
echo "run tail -f $log_file in a new terminal to watch the install"

echo -e "\n"
echo "What this script gets you:"
echo " * Pyenv to easily switch between python versions."
echo " * pipenv and poetry to manage dependencies"

echo -e "\nThis script is always changing."
echo "Make sure you got it from current master"

# Checking pyenv installation and trying to install, if needed

which pyenv
if [ $? -eq 1 ] ; then
  if [[ $MACHTYPE = *linux* ]] ; then
    echo "Trying to install pyenv with pyenv installer"
    # Check if the user has sudo privileges.
    sudo -v >/dev/null 2>&1 || { echo $script_runner has no sudo privileges ; exit 1; }

    # Install prerequisites from https://github.com/pyenv/pyenv/wiki/Common-build-problems
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm \
xz-utils tk-dev libffi-dev liblzma-dev python3-pip python3-openssl git
    sudo apt install libedit-dev

    # Install pyenv
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    export PATH="/home/$script_runner/.pyenv/bin:$PATH"
  elif [[ $MACHTYPE = *darwin* ]] ; then
    brew install zlib
    brew install sqlite
    brew install postgresql
    export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
    export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"
    export LDFLAGS="${LDFLAGS} -L/usr/local/opt/sqlite/lib"
    export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/sqlite/include"
    export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
    export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/sqlite/lib/pkgconfig"
    brew install pyenv
  fi
fi

which pyenv
if [ $? -eq 1 ] ; then
  echo "It appears that automatic installation of pyenv failed, you should try to do it manually."
  exit 1
fi

if [[ ! -e .python-version ]]; then
    echo "3.6.6" > .python-version
fi

pyenv install

# "set -e" causes the shell to exit if any subcommand or pipeline returns a non-zero status.
set -e

echo "Running 'eval "$(pyenv init -)"', make sure you add it to your bash_init script."
eval "$(pyenv init -)"

if [[ $MACHTYPE = *linux* ]] ; then
    sudo -H pip3 install --upgrade pip
    sudo pip3 install pipenv poetry
elif [[ $MACHTYPE = *darwin* ]] ; then
    pip install --upgrade pip
    pip install pipenv poetry
fi


echo -e "\n#################################"
echo    "### Installation is complete! ###"
echo -e "#################################\n"





