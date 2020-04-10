# EchoPwn
#### This is a recon tool which allows you to discover the subdomains used by a target web application on both client and server side.Then runs Dirsearch on the resulted text file. It can also scans for open ports using NMAP and runs crawler on every live Host.

![EchoPwn](https://github.com/hackerspider1/echopwn/blob/master/echopwn.png)

# Usage

```
./EchoPwn.sh domain.com                      //For Default Scan
./EchoPwn.sh domain.com -nmap                //To run nmap on your results
./EchoPwn.sh domain.com -arjun               //To run arjun on your results
./EchoPwn.sh domain.com -nmap -arjun         //For full scan
```
# Requirements:

## Amass

### Installation
#### Mac OS
```
brew tap caffix/amass
brew install amass
```

#### Linux
```
apt-get install amass
```

### Aquatone
```
gem install aquatone
```
### Findomain
#### Mac OS
```
brew install findomain
```
#### Linux
```
apt-get install findomain
```
### Dnsgen
```
pip3 install dnsgen
```
# Coming Soon
### Slack
### GITROBE
### AWS CLI


# Thanks
#### This script uses tools which are developed by the following people
[OWASP](https://github.com/OWASP/), [ProjectDiscovery](https://github.com/projectdiscovery/), [Tom Hudson](https://github.com/tomnomnom/), [Michael Henriksen](https://github.com/michenriksen/), [Gwendal Le Coguic](https://github.com/gwen001/), [Eduard Tolosa](https://github.com/Edu4rdSHL/), [B. Blechschmidt](https://github.com/blechschmidt/), [ProjectAnte](https://github.com/ProjectAnte/), [Somdev Sangwan](https://github.com/s0md3v/), [Mauro Soria](https://github.com/maurosoria/), [santiko](https://github.com/santiko/), [Ahmed Aboul-Ela](https://github.com/aboul3la/)
