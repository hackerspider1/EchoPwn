
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
# Installation:
#### Only for MacOS and Linux
```
./install.sh
```
Some Tools require manual downloading of pre-built binaries (or build them yourself):
1. [Subfinder](https://github.com/projectdiscovery/subfinder/releases/)
2. [Assestfinder](https://github.com/tomnomnom/assetfinder/releases)
3. [Aquatone](https://github.com/michenriksen/aquatone/releases/tag/v1.7.0)

Download (or build) and place these binaries in the `EchoPwn` directory.

Apart from the tokens required by individual tools, this script requires 4 tokens:
- FaceBook Token
- Github Token
- Spyse Token
- VirusTotal Token

Place these tokens in `tokens.txt` before running `EchoPwn.sh`

# Coming Soon
* Slack
* Gitrob
* AWS cli


# Thanks
#### This script uses tools which are developed by the following people
[OWASP](https://github.com/OWASP/), [ProjectDiscovery](https://github.com/projectdiscovery/), [Tom Hudson](https://github.com/tomnomnom/), [Michael Henriksen](https://github.com/michenriksen/), [Gwendal Le Coguic](https://github.com/gwen001/), [Eduard Tolosa](https://github.com/Edu4rdSHL/), [B. Blechschmidt](https://github.com/blechschmidt/), [ProjectAnte](https://github.com/ProjectAnte/), [Somdev Sangwan](https://github.com/s0md3v/), [Mauro Soria](https://github.com/maurosoria/), [santiko](https://github.com/santiko/), [Ahmed Aboul-Ela](https://github.com/aboul3la/)
