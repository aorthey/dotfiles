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
echo "Make KLAMPT"
mkdir -p ~/git/
cd ~/git/
git clone git@github.com:orthez/Klampt.git
cd ~/git/Klampt/Library/
git clone git@github.com:orthez/KrisLibrary.git
make unpack-deps; make deps
cd ..
cmake .
make -j5
./SimTest data/athlete_fractal_1.xml

echo "Make OMPL"
cd ~/Downloads
wget http://ompl.kavrakilab.org/install-ompl-ubuntu.sh
chmod +x install-ompl-ubuntu.sh
./install-ompl-ubuntu.sh --app

echo "Make orthoklampt"
