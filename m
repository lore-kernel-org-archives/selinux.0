Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA20292
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 11:38:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA24125
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 16:37:31 GMT
Received: from unirel.unirel.it (unirel.unirel.it [194.91.224.65])
	by jazzswing.ncsc.mil  with ESMTP id QAA24121
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 16:37:29 GMT
Received: from there ([10.10.14.1])
	by unirel.unirel.it (8.11.2/linuxconf) with SMTP id g1KGa9s02252
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 17:36:09 +0100
Message-Id: <200202201636.g1KGa9s02252@unirel.unirel.it>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Giovanni Mugnai <giovanni@unirel.it>
To: selinux@tycho.nsa.gov
Subject: Some questions?
Date: Wed, 20 Feb 2002 17:42:25 +0100
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I' trying to install and make working selinux on a red hat 7.2. I downloaded 
the LSM patch against kernel 2.4.17 (i had already installed the 2.4.17 
kernel) and the SELinux archive, so i followed the READMY instruction
i found inside it.

Configuring the kernel i found, and set, the "Security Option" as reported in 
the README, but i found, and set, only the "Network Packet Filtering" option 
from the "Networking Options". I couldn't find neither "Kernel/User Netlink 
Socket" and "Routing Messages". 
There's someone can explain me why? 
There could be problems?

I went on to install, i am at the point 8 of the README,   my passwd
file is:

root:x:0:0:root:/root:/bin/bash
sysadm:x:400:0:sysadm:/home/sysadm:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
news:x:9:13:news:/var/spool/news:
uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
gopher:x:13:30:gopher:/var/gopher:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:99:99:Nobody:/:/sbin/nologin
mailnull:x:47:47::/var/spool/mqueue:/dev/null
rpm:x:37:37::/var/lib/rpm:/bin/bash
xfs:x:43:43:X Font Server:/etc/X11/fs:/bin/false
ntp:x:38:38::/etc/ntp:/sbin/nologin
rpc:x:32:32:Portmapper RPC user:/:/bin/false
gdm:x:42:42::/var/gdm:/sbin/nologin
rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
nscd:x:28:28:NSCD Daemon:/:/bin/false
ident:x:98:98:pident user:/:/sbin/nologin
radvd:x:75:75:radvd user:/:/bin/false
postgres:x:26:26:PostgreSQL Server:/var/lib/pgsql:/bin/bash
apache:x:48:48:Apache:/var/www:/bin/false
squid:x:23:23::/var/spool/squid:/dev/null
named:x:25:25:Named:/var/named:/bin/false
pcap:x:77:77::/var/arpwatch:/bin/nologin
guest:x:500:500:guest:/home/guest:/bin/bash

I'm at the beginning so there's someone that could help me to know which 
users put in the context_file and which in the cron_context file?

thank you very much
Giovanni Mugnai

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
