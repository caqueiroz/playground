#!/bin/bash

apt-get remove -y docker \
                       docker-engine docker.io containerd runc
apt-get update -y

apt-get install -y git jq apt-transport-https \
                        ca-certificates curl \
                        gnupg-agent python-dev \
                        software-properties-common \
                        gcc make build-essential \
                        perl python-pip


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update -y

apt-get install -y docker-ce \
                        docker-ce-cli \
                        containerd.io
pip install --upgrade pip
pip install zipp==1.0.0
pip install docker-compose --upgrade

systemctl enable docker.service
if ( systemctl status docker.service ); then 
  systemctl stop docker.service
fi
if ! ( grep "/usr/bin/dockerd -H 0.0.0.0:2375" /lib/systemd/system/docker.service ); then 
  echo "Changing docker.service to bind 0.0.0.0:2375"
  sed -i 's/^ExecStart=\/usr\/bin\/dockerd/ExecStart=\/usr\/bin\/dockerd -H 0.0.0.0:2375/g' /lib/systemd/system/docker.service
  systemctl daemon-reload
else
  echo "already set up -H 0.0.0.0:2375"
fi
systemctl start docker.service

sudo bash -c 'cat > /etc/profile.d/docker.sh  << EOF
#!/bin/bash
export DOCKER_HOST="tcp://localhost:2375"
EOF
'

{
  su - vagrant -c "git clone https://github.com/caqp13/playground.git"
} || {
  echo "Ignore the error above, the repo already existis locally"
  su - vagrant -c "cd ~/playground;git pull"
}

{
  su - vagrant -c "git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1"
} || {
  echo "Ignore the error above, the repo already existis locally"
  su - vagrant -c "cd ~/.bash-git-prompt;git pull"
}

su - vagrant -c 'cat >> ~/.bashrc << EOF
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh
EOF
'
su - vagrant -c "ln -s ~/playground/docker/docker_icetea_jenkins ~/docker_icetea_jenkins"


echo "the END"
