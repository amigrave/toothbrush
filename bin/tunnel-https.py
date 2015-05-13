#!/usr/bin/python
import inspect
import select
import socket
import sys


def tunnel(target_host, target_port=8080, proxy_ip='127.0.0.1', proxy_port=3128, proxy_login=None,
           proxy_password=None, tunnel_port=22222, user_agent=None):
    """
        tunnel: Make localhost:<tunnel_port> mapped to <target>:<target_port> via an http proxy
                works on cygwin.
        drawback: Only one connection at a given time
    """
    if user_agent is None:
        user_agent = ("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko)"
                      " Ubuntu Chromium/39.0.2171.65 Chrome/39.0.2171.65 Safari/537.36")
    sl = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        sl.bind(('', tunnel_port))
    except:
        print("Cannot bind localhost: %s" % tunnel_port)
        sys.exit()
    sl.listen(1)
    while 1:
        print("Listening to %s" % tunnel_port)
        conn, addr = sl.accept()
        print("Connected by {addr}. Connecting to {target_host} via proxy {proxy_ip}".format(**locals()))
        t = "CONNECT %s:%d HTTP/1.1\r\nUser-Agent: %s\r\nProxy-Connection: keep-alive\r\nHost: %s"
        if proxy_login:
            auth = (proxy_login + ":" + proxy_password).encode("base64").strip()
            t += "\r\nProxy-Authorization: Basic %s" % auth
        t += "\r\n\r\n"
        t = t % (target_host, target_port, user_agent, target_host)
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        print("Connected to proxy, sending command", repr(t))
        s.connect((proxy_ip, int(proxy_port)))
        s.send(t)
        data = s.recv(1024)
        print("Proxy said: %r" % data)
        end = data.find('\r\n\r\n')
        conn.send(data[end + 4:])
        loop = 1
        c_in = 0
        c_out = 0
        while loop:
            r = select.select([conn, s], [], [], 5)
            for f in r[0]:
                if f == conn:
                    data = conn.recv(2048)
                    c_out += len(data)
                    if len(data) == 0:
                        loop = 0
                    s.send(data)
                    print "in:", c_in, " out:", c_out, " last-out:", len(data)
                elif f == s:
                    data = s.recv(2048)
                    c_in += len(data)
                    if len(data) == 0:
                        loop = 0
                    conn.send(data)
                    print "in:", c_in, " out:", c_out, " last-in:", len(data)
        s.close()

if __name__ == '__main__':
    fnargs = inspect.getargspec(tunnel).args
    args = sys.argv[1:]
    if not args:
        sys.exit("tunnel <host>")
    host = args.pop(0)
    if args:
        # TODO: map to fnargs
        pass
    tunnel(host)
