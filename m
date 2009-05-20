Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4KHNcmn026926
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 13:23:38 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n4KHNaIv016640
	for <selinux@tycho.nsa.gov>; Wed, 20 May 2009 17:23:45 GMT
Subject: Incorrect avc logs for the packet object class
From: Marshall Miller <mmiller@tresys.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 20 May 2009 13:23:15 -0400
Message-Id: <1242840195.22878.339.camel@hostmachine.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I first noticed this bug on a RHEL 5 system, and I also noticed it on
Ubuntu Jaunty.  I tested this out on Fedora 11 Preview and it was there
also.

The avc messages for the packet object class sporadically report
incorrect comm/pid info.  It is most apparent when multiple processes
are sending/receiving packets at the same time.  To demonstrate this, I
added an iptables rule such that every packet being sent is labeled
system_u:object_r:dns_client_packet_t:s0 (arbitrarily chosen from
existing types).  I then created and inserted a module that auditallows
all packet perms for subj == domain and obj == dns_client_packet_t.
Then I started the Software Updater, and when it started downloading
packages I ran firefox.

Distribution:
Fedora 11 Preview

Output of uname -r:
2.6.29.2-126.fc11.i586

Package versions:
libselinux-2.0.80-1
libsemanage-2.0.31-4
libselinux-2.0.80-1
libsepol-2.0.36-1
policycoreutils-2.0.62-12.2
selinux-policy-targeted-3.6.12-34

Here are some sample log messages:

type=AVC msg=audit(1242832297.363:16691): avc:  granted  { send } for
pid=2025 comm="firefox" saddr=10.1.13.199 src=41508 daddr=204.152.191.39
dest=80 netif=eth0 scontext=system_u:system_r:rpm_t:s0-s0:c0.c1023
tcontext=system_u:object_r:dns_client_packet_t:s0 tclass=packet

type=AVC msg=audit(1242832297.363:16692): avc:  granted  { send } for
pid=1787 comm="gnome-volume-co" saddr=10.1.13.199 src=41508
daddr=204.152.191.39 dest=80 netif=eth0
scontext=system_u:system_r:rpm_t:s0-s0:c0.c1023
tcontext=system_u:object_r:dns_client_packet_t:s0 tclass=packet

type=SYSCALL msg=audit(1242832297.363:16692): arch=40000003 syscall=39
success=yes exit=0 a0=8ddc638 a1=1c0 a2=52311d8 a3=8ddc64e items=0
ppid=1648 pid=1787 auid=500 uid=500 gid=500 euid=500 suid=500 fsuid=500
egid=500 sgid=500 fsgid=500 tty=(none) ses=1 comm="gnome-volume-co"
exe="/usr/bin/gnome-volume-control-applet"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

type=AVC msg=audit(1242832297.365:16693): avc:  granted  { send } for
pid=1015 comm="auditd" saddr=10.1.13.199 src=41508 daddr=204.152.191.39
dest=80 netif=eth0 scontext=system_u:system_r:rpm_t:s0-s0:c0.c1023
tcontext=system_u:object_r:dns_client_packet_t:s0 tclass=packet


Firefox is actually running as unconfined_execmem_t and
gnome-volume-control-applet is running as unconfined_t, as can been seen
by output from ps:

unconfined_u:unconfined_r:unconfined_execmem_t:SystemLow-SystemHigh
mmiller 2025 2010  1 11:10 ? 00:00:10 /usr/lib/firefox-3.5b4/firefox

unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh mmiller 1787
1648  1 11:09 ? 00:00:39 gnome-volume-control-applet


It is also strange that event 16692 has a packet AVC message and also a
SYSCALL message for the mkdir syscall.  I don't see how these messages
are related.


Contents of policy module:
policy_module(auditallow_packets,1.0.0)
gen_require(`
	class packet all_packet_perms;
	attribute domain;
	type dns_client_packet_t;
')
auditallow domain dns_client_packet_t:packet *;


Contents of /etc/sysconfig/iptables:
*mangle
:PREROUTING ACCEPT [0:0]
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:POSTROUTING ACCEPT [0:0]
-A OUTPUT -j SECMARK --selctx system_u:object_r:dns_client_packet_t:s0 
COMMIT



-- 
Marshall Miller
Tresys Technology
443-539-0710


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
