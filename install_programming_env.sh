#ssh -q -T git@github.com && echo $host SSH_OK || echo $host SSH_NOK

SSHKEY=~/.ssh/id_rsa.pub
echo $SSHKEY
if [ -f $SSHKEY ]; then
  echo "Your ssh key: "
  cat $SSHKEY
else
  yes|ssh-keygen
  echo "Add your ssh key to GITHUB now!"
  echo "Your ssh key: "
  cat $SSHKEY
  firefox https://github.com/settings/keys
fi

git ls-remote git@github.com:orthez/orthoklampt.git &>-
if [ "$?" -ne 0 ]; then
  echo "[ERROR] Unable to read from '$SITE_REPO_URL'"
  exit 1
fi

echo "ssh key setup"
echo "Make Custom Programming Environment"
mkdir -p ~/git/
cd ~/git/

echo "Make Vimperator-labs"

cd ~/git/
git clone git@github.com:vimperator/vimperator-labs.git
cd vimperator-labs
make xpi

echo "Make KLAMPT"
git clone git@github.com:orthez/Klampt.git
cd ~/git/Klampt/Library/
git clone git@github.com:orthez/KrisLibrary.git
make unpack-deps; make deps
cd ..
cmake .
make -j5
./SimTest data/athlete_fractal_1.xml

echo "Make CGAL 4.10"
cd ~/git/
wget
https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.10/CGAL-4.10.tar.xz
tar xf CGAL-4.10.tar.xz
cd CGAL-4.10
cmake .
make -j5
sudo make install

echo "Make OMPL"
cd ~/Downloads
wget http://ompl.kavrakilab.org/install-ompl-ubuntu.sh
chmod +x install-ompl-ubuntu.sh
./install-ompl-ubuntu.sh --app

echo "Make orthoklampt"
cd ~/git/
git clone git@github.com:orthez/orthoklampt.git
cd orthoklampt
mkdir build
cd build
cmake .. && make -j5


echo "Make SBL"
sagi coinor-libipopt-dev
sagi seqan
cd ~/git/ 
wget http://sbl.inria.fr/downloads/sbl-1.0.0.tgz
tar xfv sbl-1.0.0.tgz
cd sbl
mkdir build
cd build
#cmake .. -DSBL_DOWNLOAD_PROGRAMS_LINUX=ON -DSBL_APPLICATIONS=ON
#
cmake ..
#-DSBL_TESTS=ON
#cmake .. -DSBL_APPLICATIONS=ON
make
sudo make install

