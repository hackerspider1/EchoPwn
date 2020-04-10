import sys
import socket

fileofw = open(sys.argv[1], "r")

for zub in fileofw:
	zub = zub.rstrip()
	try:
		word = "asdjasndiasndaisnfasiiawnfafia0zzzzajdaoifjaa9830"
		dom = word + "." + zub
		socket.gethostbyname(dom)
	except socket.gaierror:
		print(zub)

