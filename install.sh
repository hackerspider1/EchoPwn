pip3 install -r requirements.txt
chmod +x EchoPwn.sh

#Tools

#arjun
git clone https://github.com/s0md3v/Arjun.git

#Photon
git clone https://github.com/s0md3v/Photon.git

#Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git

#dirsearch
git clone https://github.com/maurosoria/dirsearch.git

#subdomain-takeover
git clone https://github.com/antichown/subdomain-takeover.git

#Aquatone
echo "Installing Aquatone-discover"
gem install aquatone

#Amass
echo "Installing Amass"

#cloning massdns
git clone https://github.com/blechschmidt/massdns.git

if [[ $(uname) = 'Darwin' ]]
then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew tap caffix/amass
  brew install amass findomain nmap

  echo "Installing MassDNS"
  cd massdns; make nolinux; cd ..

else
  sudo apt-get update
  sudo apt-get install -y amass nmap golang

  echo "Installing Findomain"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
  chmod +x findomain-linux
  mv findomain-linux findomain

  echo "Installing MassDNS"
  cd massdns; make; cd ..

fi

go get -u github.com/tomnomnom/httprobe
