Subject: named.
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 03 Jul 2002 16:44:39 -0400
Message-Id: <1025729079.3619.133.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does bind 9 not work with SE?

I keep getting messages about named trying to bind to port 13568 and
then failing to attach itself to any interface.  I've looked through the
isc bind 9 archives to try and find anything about binding to this port
with no luck and although named starts it never binds properly to port
53.  I started with the named files off of my current working name
server to save time.  However when it appeared that the lack of
instructions on where to bind itself prevented it from working properly
I added specific listen-on statements in the named.conf and it still
does the same thing.  I've relabeled all the files since I installed
bind with no luck and, as I mentioned, search the bind archives with no
luck.  I tried these archives from the NSA site but all I could find was
a message from Russel with changes to allow bind to attach itself to tcp
53. Below is the named and avc messages and I can attach the named.conf
or any other information if someone needs.

Timothy,

named[2625]: starting BIND 9.2.0 -u named
named[2625]: using 1 CPU
named[2628]: loading configuration from '/etc/named.conf'
named[2628]: no IPv6 interfaces found
named[2628]: listening on IPv4 interface lo, 127.0.0.1#53
kernel: 
kernel: avc:  denied  { name_bind } for  pid=2628 exe=/usr/sbin/named
port=13568 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:named_port_t tclass=udp_socket
named[2628]: could not listen on UDP socket: permission denied
named[2628]: creating IPv4 interface lo failed; interface ignored
named[2628]: listening on IPv4 interface eth0, 192.168.42.242#53
kernel: 
kernel: avc:  denied  { name_bind } for  pid=2628 exe=/usr/sbin/named
port=13568 scontext=root:sysadm_r:sysadm_t
tcontext=system_u:object_r:named_port_t tclass=udp_socket
named[2628]: could not listen on UDP socket: permission denied
named[2628]: creating IPv4 interface eth0 failed; interface ignored
named[2628]: not listening on any interfaces
named[2628]: command channel listening on 127.0.0.1#953
named[2628]: zone 0.0.127.in-addr.arpa/IN: loaded serial 1997022700
named[2628]: zone localhost/IN: loaded serial 42
named[2628]: running
named: named startup succeeded


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
