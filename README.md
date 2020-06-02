

# EchoPwn
#### This is a recon tool which allows you to discover the subdomains used by a target web application on both client and server side. Afterwards, it runs dirsearch on the resulted text file. It can also scan for open ports using NMAP and finds hidden parameters on every live Host.

![EchoPwn](https://github.com/hackerspider1/echopwn/blob/master/Readme/echopwn.png)

# Usage

```
Usage: ./EchoPwn.sh [options] -d domain.com
Options:
    -h            Display this help message.
    -k            Run Knockpy on the domain.
    -n            Run Nmap on all subdomains found.
    -a            Run Arjun on all subdomains found.
    -p            Run Photon crawler on all subdomains found.
    -b            Run Custom Bruteforcer to find subdoamins.

  Target:
    -d            Specify the domain to scan.

Example:
    ./EchoPwn.sh -d hackerone.com

Output will be saved in EchoPwn/domain.com/ directory
```

![EchoPwn.gif](https://github.com/hackerspider1/EchoPwn/blob/master/Readme/Echopwn.gif)

# Workflow:
 `install.sh` makes environment to run `EchoPwn.sh`
  `EchoPwn.sh` creates a directory `EchoPwn/domain_name` in current working directory.
1. **Subdomain Enumeration**
	- Sublist3r
	- crt.sh
	- amass
	- subfinder
	- assetfinder
	- aquatone-discover
	- findomain
	- github-subdomains
	- custom bruteforcer with `subdomains.txt` as input file.
	- **Optional:** knockpy

2. **Checking for live subdomains**
	- httprobe

3. **Screenshots**
	- aquatone

4. **Directory Bruteforce**
	- dirsearch

5. **Optional**
	- -n [Nmap] &emsp;&emsp;&emsp; Probe open ports to determine service/version info
	- -a [Arjun] &emsp; &emsp;&emsp; Scans for hidden parameters on live hosts
	- -p [Proton] &emsp;&emsp; Crawls all live hosts [takes time and creates lots of files]
  - -b [Custom Bruteforcer] &emsp;&emsp; Runs custom bruteforcer to find subdomains
	- -k [KnockPy] &emsp;&emsp;&emsp; Bruteforce subdomains [takes time and saves output in current working directory (in json format)]

6. **Slack Notification**
	- WebHook URL placed in `tokens.txt` will be used to notify the user once the script has finished running.

![Slack](https://github.com/hackerspider1/EchoPwn/blob/master/Readme/slack_url.png)

Final list of subdomains will be present in `EchoPwn/domain_name` directory.
Outputs corresponding to the tools will also be present in the same directory.

# Installation and Requirements:
#### Only for MacOS and Linux
##### Prerequisites
1. go
2. gem

Then run:
```
./install.sh
```
Some Tools require manual downloading of pre-built binaries (or build them yourself):
1. [Subfinder](https://github.com/projectdiscovery/subfinder/releases/)
2. [Assestfinder](https://github.com/tomnomnom/assetfinder/releases)
3. [Aquatone](https://github.com/michenriksen/aquatone/releases/tag/v1.7.0)

Download (or build) and place these binaries in the `EchoPwn` directory.

Apart from the tokens required by individual tools, this script requires 4 additional values:
- FaceBook Token
- Github Token
- Spyse Token
- VirusTotal Token
- Slack WebHook URL

Place these values in `tokens.txt` before running `EchoPwn.sh`


**NOTE**
1. If you face Import error (Queue) while running altdns, you have to manually change __main__.py file mentioned in the error. Do the following change
Before: `Import Queue from Queue as Queue`
After: `Import queue from Queue as Queue`

2. To set GOPATH, use the following command:
`export $GOPATH=~/go/bin`

Suggestions are welcomed.
Mail us at: **admin@echopwn.com**


# Thanks
#### This script uses tools which are developed by the following people
[OWASP](https://github.com/OWASP/), [ProjectDiscovery](https://github.com/projectdiscovery/), [Tom Hudson](https://github.com/tomnomnom/), [Michael Henriksen](https://github.com/michenriksen/), [Gwendal Le Coguic](https://github.com/gwen001/), [Eduard Tolosa](https://github.com/Edu4rdSHL/), [B. Blechschmidt](https://github.com/blechschmidt/), [ProjectAnte](https://github.com/ProjectAnte/), [Somdev Sangwan](https://github.com/s0md3v/), [Mauro Soria](https://github.com/maurosoria/), [Gianni Amato](https://gitub.com/guelfoweb/), [Ahmed Aboul-Ela](https://github.com/aboul3la/)
