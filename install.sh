pip3 install -r requirements.txt

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
  sudo apt-get install amass nmap

  echo "Installing Findomain"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
  chmod +x findomain-linux
  echo "alias findomain='$(pwd)/findomain-linux'" >> ~/.bashrc

  echo "Installing MassDNS"
  cd massdns; make; cd ..

fi

go get -u github.com/tomnomnom/httprobe
