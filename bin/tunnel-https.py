#!/usr/bin/python
import fcntl,os,select,socket,sys,time

# tunnel: Make localhost:2222 mapped to TARGET:443 via an http proxy
# Drawback: Only one connection at a given time

PROXY_IP="193.210.163.73"
PROXY_PORT="8080"
PROXY_LOGIN=""
PROXY_PASSWD=""
TUNNEL_PORT_LOCAL=22

TARGET="agr.homelinux.org"

AGENT="Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.366.2 Safari/533.4"

def tunnel():
	sl = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	try:
		sl.bind(('',TUNNEL_PORT_LOCAL))
	except:
		print "Cannot bind localhost:" + str(TUNNEL_PORT_LOCAL)
		sys.exit()
	sl.listen(1)
	while 1:
		print 'Listening to ' + str(TUNNEL_PORT_LOCAL)
		conn,addr=sl.accept()
		print 'Connected by', addr,'. Connecting to '+TARGET+' via proxy '+PROXY_IP
		t="CONNECT %s:%d HTTP/1.1\r\nUser-Agent: %s\r\nProxy-Connection: keep-alive\r\nHost: %s\r\nProxy-Authorization: Basic %s\r\n\r\n"
		auth= (PROXY_LOGIN + ":" + PROXY_PASSWD).encode("base64").strip()
		t=t%(TARGET, 443, AGENT, TARGET, auth)
		s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.setsockopt(socket.SOL_SOCKET,socket.SO_REUSEADDR,1)
		print 'Connected to proxy, sending command',repr(t)
		s.connect( (PROXY_IP, int(PROXY_PORT)) )
		s.send(t)
		data=s.recv(1024)
		print "Proxy said: "+repr(data)
		# Should be 'HTTP/1.0 200 Connection established\r\nProxy-agent: iPlanet-Web-Proxy-Server/3.6-SP5\r\n\r\n'
		end=data.find('\r\n\r\n')
		conn.send(data[end+4:])
		loop=1
		c_in=0
		c_out=0
		while loop:
			r=select.select([conn,s],[],[],5)
			for f in r[0]:
				if f==conn:
					data=conn.recv(2048)
					c_out+=len(data)
					if len(data)==0:
						loop=0
					s.send(data)
					print "in:",c_in," out:",c_out," last-out:",len(data)
#					print repr(data)
				elif f==s:
					data=s.recv(2048)
					c_in+=len(data)
					if len(data)==0:
						loop=0
					conn.send(data)
					print "in:",c_in," out:",c_out," last-in:",len(data)
#					print repr(data)
		s.close()

def vpn():
	pid=os.fork()
	if pid==0:
		os.setsid()
		tunnel()
	else:
		os.system(" route del default gw 192.168.229.2;")
		os.system(" route add -net 158.169.0.0 netmask 255.255.0.0 gw 192.168.229.2;")
		os.system(" route add -net 158.166.0.0 netmask 255.255.0.0 gw 192.168.229.2;")
		time.sleep(0.1)
		local="192.168.1.202"
		remote="192.168.1.2"
		opt="lcp-max-configure 5 lcp-echo-failure 1 lcp-echo-interval 50 noauth proxyarp"
		cmd='pppd updetach connect-delay 5000 %s pty "ssh -i /home/wis/.ssh/id_rsa -t -p ' + str(TUNNEL_PORT_LOCAL) + ' root@localhost /usr/sbin/pppd %s" %s:%s'
		cmd=cmd%(opt,opt,local,remote)
		print cmd
		os.system(cmd)
		os.system("route add -net 192.168.1.0 netmask 255.255.255.0 gw %s; route add default gw %s"%(remote,remote))

# Tunnel-only version also works under cygwin
tunnel()

# VPN version only works under linux
#vpn()

