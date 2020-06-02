#!/bin/bash
echo "
 _____     _           ____
| ____|___| |__   ___ |  _ \__      ___ __
|  _| / __| '_ \ / _ \| |_) \ \ /\ / / '_ \\
| |__| (__| | | | (_) |  __/ \ V  V /| | | |
|_____\___|_| |_|\___/|_|     \_/\_/ |_| |_|v1.1

"

help(){
  echo "
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
"
}

POSITIONAL=()

if [[ "$*" != *"-d"* ]]
then
	help
  exit
fi

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|--help)
    help
    exit
    ;;
    -d|--domain)
    d="$2"
    shift
    shift
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo "Starting SubEnum $d"

echo "Creating directory"
set -e
if [ ! -d $PWD/EchoPwn ]; then
	mkdir EchoPwn
fi
if [ ! -d $PWD/EchoPwn/$d ]; then
	mkdir EchoPwn/$d
fi
source tokens.txt

echo "Starting our subdomain enumeration force..."


if [[ "$*" = *"-k"* ]]
then
	echo "Starting KnockPy"
	mkdir EchoPwn/$d/knock
	cd EchoPwn/$d/knock; python ../../../knock/knockpy/knockpy.py "$d" -j; cd ../../..
fi

echo "Starting Sublist3r..."
python3 Sublist3r/sublist3r.py -d "$d" -o EchoPwn/$d/fromsublister.txt

echo "Amass turn..."
amass enum --passive -d $d -o EchoPwn/$d/fromamass.txt

echo "Starting subfinder..."
./subfinder -d $d -o EchoPwn/$d/fromsubfinder.txt -v --exclude-sources dnsdumpster

echo "Starting assetfinder..."
./assetfinder --subs-only $d > EchoPwn/$d/fromassetfinder.txt

echo "Starting aquatone-discover"
aquatone-discover -d $d --disable-collectors dictionary -t 300
rm -rf amass_output
cat ~/aquatone/$d/hosts.txt | cut -f 1 -d ',' | sort -u >> EchoPwn/$d/fromaquadiscover.txt
rm -rf ~/aquatone/$d/

echo "Starting github-subdomains..."
python3 github-subdomains.py -t $github_token_value -d $d | sort -u >> EchoPwn/$d/fromgithub.txt

echo "Starting findomain"
export findomain_fb_token="$findomain_fb_token"
export findomain_spyse_token="$findomain_spyse_token"
export findomain_virustotal_token="$findomain_virustotal_token"

./findomain -t $d -r -u EchoPwn/$d/fromfindomain.txt

nl=$'\n'
echo "Starting bufferover"
curl "http://dns.bufferover.run/dns?q=$d" --silent | jq '.FDNS_A | .[]' -r 2>/dev/null | cut -f 2 -d',' | sort -u >> EchoPwn/$d/frombufferover-dns.txt
echo "$nl"
echo "Bufferover DNS"
echo "$nl"
cat EchoPwn/$d/frombufferover-dns.txt
curl "http://dns.bufferover.run/dns?q=$d" --silent | jq '.RDNS | .[]' -r 2>/dev/null | cut -f 2 -d',' | sort -u >> EchoPwn/$d/frombufferover-dns-rdns.txt
echo "$nl"
echo "Bufferover DNS-RDNS"
echo "$nl"
cat EchoPwn/$d/frombufferover-dns-rdns.txt
curl "http://tls.bufferover.run/dns?q=$d" --silent | jq '. | .Results | .[]'  -r 2>/dev/null | cut -f 3 -d ',' | sort -u >> EchoPwn/$d/frombufferover-tls.txt
echo "$nl"
echo "Bufferover TLS"
echo "$nl"
cat EchoPwn/$d/frombufferover-tls.txt

if [[ "$*" = *"-b"* ]]
then
  echo "Starting our custom bruteforcer"
  for sub in $(cat subdomains.txt); do echo $sub.$d >> /tmp/sub-$d.txt; done
  ./massdns/bin/massdns -r massdns/lists/resolvers.txt -s 1000 -q -t A -o S -w /tmp/subresolved-$d.txt /tmp/sub-$d.txt
  rm /tmp/sub-$d.txt
  awk -F ". " "{print \$d}" /tmp/subresolved-$d.txt | sort -u >> EchoPwn/$d/fromcustbruter.txt
  rm /tmp/subresolved-$d.txt
fi
cat EchoPwn/$d/*.txt | grep $d | grep -v '*' | sort -u  >> EchoPwn/$d/alltogether.txt

echo "Deleting other(older) results"
rm -rf EchoPwn/$d/from*

echo "Resolving - Part 1"
./massdns/bin/massdns -r massdns/lists/resolvers.txt -s 1000 -q -t A -o S -w /tmp/massresolved1.txt EchoPwn/$d/alltogether.txt
awk -F ". " "{print \$1}" /tmp/massresolved1.txt | sort -u >> EchoPwn/$d/resolved1.txt
rm /tmp/massresolved1.txt
rm EchoPwn/$d/alltogether.txt

echo "Removing wildcards"
python3 wildcrem.py EchoPwn/$d/resolved1.txt >> EchoPwn/$d/resolved1-nowilds.txt
rm EchoPwn/$d/resolved1.txt

echo "Starting AltDNS..."
altdns -i EchoPwn/$d/resolved1-nowilds.txt -o EchoPwn/$d/fromaltdns.txt -t 300

echo "Resolving - Part 2 - Altdns results"
./massdns/bin/massdns -r massdns/lists/resolvers.txt -s 1000 -q -o S -w /tmp/massresolved1.txt EchoPwn/$d/fromaltdns.txt
awk -F ". " "{print \$1}" /tmp/massresolved1.txt | sort -u >> EchoPwn/$d/altdns-resolved.txt
rm /tmp/massresolved1.txt
rm EchoPwn/$d/fromaltdns.txt

echo "Removing wildcards - Part 2"
python3 wildcrem.py EchoPwn/$d/altdns-resolved.txt >> EchoPwn/$d/altdns-resolved-nowilds.txt
rm EchoPwn/$d/altdns-resolved.txt

cat EchoPwn/$d/*.txt | sort -u >> EchoPwn/$d/alltillnow.txt
rm EchoPwn/$d/altdns-resolved-nowilds.txt
rm EchoPwn/$d/resolved1-nowilds.txt

echo "Starting DNSGEN..."
dnsgen EchoPwn/$d/alltillnow.txt >> EchoPwn/$d/fromdnsgen.txt

echo "Resolving - Part 3 - DNSGEN results"
./massdns/bin/massdns -r massdns/lists/resolvers.txt -s 1000 -q -t A -o S -w /tmp/massresolved1.txt EchoPwn/$d/fromdnsgen.txt
awk -F ". " "{print \$1}" /tmp/massresolved1.txt | sort -u >> EchoPwn/$d/dnsgen-resolved.txt
rm /tmp/massresolved1.txt
#rm /tmp/forbrut.txt
rm EchoPwn/$d/fromdnsgen.txt

echo "Removing wildcards - Part 3"
python3 wildcrem.py EchoPwn/$d/dnsgen-resolved.txt >> EchoPwn/$d/dnsgen-resolved-nowilds.txt
rm EchoPwn/$d/dnsgen-resolved.txt

cat EchoPwn/$d/alltillnow.txt | sort -u >> EchoPwn/$d/$d.txt
rm EchoPwn/$d/dnsgen-resolved-nowilds.txt
rm EchoPwn/$d/alltillnow.txt

echo "Appending http/s to hosts"
for i in $(cat EchoPwn/$d/$d.txt); do echo "http://$i" && echo "https://$i"; done >> EchoPwn/$d/with-protocol-domains.txt
cat EchoPwn/$d/$d.txt | ~/go/bin/httprobe | tee -a EchoPwn/$d/alive.txt

echo "Taking screenshots..."
cat EchoPwn/$d/with-protocol-domains.txt | ./aquatone -ports xlarge -out EchoPwn/$d/aquascreenshots

if [[ "$*" = *"-a"* ]]
then
	cat EchoPwn/$d/$d.txt | ~/go/bin/httprobe | tee -a EchoPwn/$d/alive.txt
	python3 Arjun/arjun.py --urls EchoPwn/$d/alive.txt --get -o EchoPwn/$d/arjun_out.txt -f Arjun/db/params.txt
fi


echo "Total hosts found: $(wc -l EchoPwn/$d/$d.txt)"

if [[ "$*" = *"-n"* ]]
then
	echo "Starting Nmap"
  if [ ! -d $PWD/EchoPwn/$d/nmap ]; then
  	mkdir EchoPwn/$d/nmap
  fi
	for i in $(cat EchoPwn/$d/$d.txt); do nmap -sC -sV $i -o EchoPwn/$d/nmap/$i.txt; done
fi

if [[ "$*" = *"-p"* ]]
then
	echo "Starting Photon Crawler"
  if [ ! -d $PWD/EchoPwn/$d/photon ]; then
  	mkdir EchoPwn/$d/photon
  fi
	for i in $(cat EchoPwn/$d/$d.txt); do python3 Photon/photon.py -u $i -o EchoPwn/$d/photon/$i -l 2 -t 50; done
fi

echo "Checking for Subdomain Takeover"
python3 subdomain-takeover/takeover.py -d $d -f EchoPwn/$d/$d.txt -t 20 | tee EchoPwn/$d/subdomain_takeover.txt

echo "Starting DirSearch"
if [ ! -d $PWD/EchoPwn/$d/dirsearch ]; then
	mkdir EchoPwn/$d/dirsearch
fi
for i in $(cat EchoPwn/$d/$d.txt); do python3 dirsearch/dirsearch.py -e php,asp,aspx,jsp,html,zip,jar -w dirsearch/db/dicc.txt -t 80 -u $i --plain-text-report="EchoPwn/$d/dirsearch/$i.txt"; done

echo "Notifying you on slack"
curl -X POST -H 'Content-type: application/json' --data '{"text":"EchoPwn finished scanning: '$d'"}' $slack_url

echo "Finished successfully."
