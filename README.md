

# EchoPwn
#### This is a recon tool which allows you to discover the subdomains used by a target web application on both client and server side. Afterwards, it runs dirsearch on the resulted text file. It can also scan for open ports using NMAP and finds hidden parameters on every live Host.

![EchoPwn](https://github.com/hackerspider1/echopwn/blob/master/echopwn.png)

# Usage

```
./EchoPwn.sh domain.com                      //For Default Scan
./EchoPwn.sh domain.com -nmap                //To run nmap on your results
./EchoPwn.sh domain.com -arjun               //To run arjun on your results
./EchoPwn.sh domain.com -nmap -arjun         //For full scan

Output will be saved in EchoPwn/domain.com/ directory
```

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
	- -nmap &emsp;&emsp;&emsp; Probe open ports to determine service/version info
	- -arjun &emsp; &emsp;&emsp; Scans for hidden parameters on live hosts
	- -photon &emsp;&emsp; Crawls all live hosts [takes time and creates lots of files]	
	- -knock &emsp;&emsp;&emsp; Bruteforce subdomains [takes time and saves output in current working directory (in json format)]

6. **Slack Notification**
	- WebHook URL placed in `tokens.txt` will be used to notify the user once the script has finished running.

![Slack](https://github.com/hackerspider1/EchoPwn/blob/master/slack_url.png)

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

# Coming Soon
* Gitrob
& more...

Suggestions are welcomed.
Mail us at: **admin@echopwn.com**


# Thanks
#### This script uses tools which are developed by the following people
[OWASP](https://github.com/OWASP/), [ProjectDiscovery](https://github.com/projectdiscovery/), [Tom Hudson](https://github.com/tomnomnom/), [Michael Henriksen](https://github.com/michenriksen/), [Gwendal Le Coguic](https://github.com/gwen001/), [Eduard Tolosa](https://github.com/Edu4rdSHL/), [B. Blechschmidt](https://github.com/blechschmidt/), [ProjectAnte](https://github.com/ProjectAnte/), [Somdev Sangwan](https://github.com/s0md3v/), [Mauro Soria](https://github.com/maurosoria/), [Gianni Amato](https://gitub.com/guelfoweb/), [Ahmed Aboul-Ela](https://github.com/aboul3la/)
