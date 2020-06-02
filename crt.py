import argparse
import requests
import json
import sys

requests.packages.urllib3.disable_warnings()
parser = argparse.ArgumentParser()
parser.add_argument('-q', '--query', help='Query, ex: %25test%25.google.com', dest='query')
args = parser.parse_args()
if not len(sys.argv) > 1:
	print("You may ask for help: python " + sys.argv[0] + " -h")
	sys.exit()

r = requests.get("https://crt.sh/?q={}&output=json".format(args.query), verify=False)
content = r.content.decode('utf-8')
data = json.loads(content)
subs = []
for subdomain in data:
	subs.append(subdomain["name_value"].lower())

newsubs = set(subs)
for sub in newsubs:
	print(sub)
