Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA12462
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 18:38:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA09226
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 22:37:27 GMT
Received: from austin.bmh.com (austin.bmh.com [216.54.77.38])
        by jazzband.ncsc.mil  with ESMTP id WAA09222 for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 22:37:27 GMT
Received: (from root@localhost)
	by austin.bmh.com (8.11.6/8.11.2) id g6LMa4905384
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 18:36:04 -0400
From: Natr Brazell <brazell@bmh.com>
Received: from bmh.com (austin.bmh.com [216.54.77.38])
	by austin.bmh.com (8.11.6/8.11.2) with SMTP id g6LMa4905299
	for <selinux@tycho.nsa.gov>; Sun, 21 Jul 2002 18:36:04 -0400
Message-ID: <63114.137.246.8.231.1027290964.squirrel@austin.bmh.com>
Date: Sun, 21 Jul 2002 18:36:04 -0400 (EDT)
Subject: =?iso-8859-1?Q?Installation_question?=
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please see the below /var/log/messages entries and tell me what I have to 
do to correct them.  2.4.18 LSM kernel in passive mode.

Jul 21 15:53:42 Foundry1CFI kernel: avc:  denied  { write } for  pid=2440 
exe=/usr/stow/JSAF5/src/JSAF/jsaf path=/usr/stow/JSAF5 dev=08:03 
ino=278875 scontext=system_u:system_r:xdm_t 
tcontext=safuser:object_r:usr_t tclass=dir

Jul 21 15:53:42 Foundry1CFI kernel: avc:  denied  { add_name } for  
pid=2440 exe=/usr/stow/JSAF5/src/JSAF/jsaf path=/usr/stow/JSAF5/profiles 
scontext=system_u:system_r:xdm_t tcontext=safuser:object_r:usr_t tclass=dir

Jul 21 15:53:42 Foundry1CFI kernel: avc:  denied  { create } for  pid=2440 
exe=/usr/stow/JSAF5/src/JSAF/jsaf path=/usr/stow/JSAF5/profiles 
scontext=system_u:system_r:xdm_t tcontext=system_u:object_r:usr_t 
tclass=dir

Jul 21 15:55:25 Foundry1CFI kernel: avc:  denied  { recvfrom } for  
pid=2445 exe=/usr/stow/JSAF5/src/JSAF/jsaf saddr=127.0.0.1 source=32770 
daddr=127.0.0.1 dest=111 netif=lo scontext=system_u:system_r:portmap_t 
tcontext=system_u:system_r:xdm_t tclass=udp_socket

Jul 21 18:12:21 j9saf-219 kernel: avc:  denied  { execute } for  pid=1629 
exe=/bin/bash path=/usr/stow/JSAF5/src/JSAF/jsaf dev=08:03 
ino=1565642 scontext=root:sysadm_r:sysadm_t 
tcontext=safuser:object_r:usr_t tclass=file
J
Jul 21 18:12:21 j9saf-219 kernel: avc:  denied  { execute_no_trans } for  
pid=1629 exe=/bin/bash path=/usr/stow/JSAF5/src/JSAF/jsaf dev=08:03 
ino=1565642 scontext=root:sysadm_r:sysadm_t 
tcontext=safuser:object_r:usr_t tclass=file

Jul 21 18:12:21 j9saf-219 kernel: avc:  denied  { execute } for  pid=1629 
exe=/usr/stow/JSAF5/src/JSAF/jsaf 
path=/usr/stow/external/pre_v6_cut4/Linux-rh7.2-i386-gcc-3.0.2-opt-
mt/lib/libRTI-NG.so dev=08:03 ino=1891107 scontext=root:sysadm_r:sysadm_t 
tcontext=system_u:object_r:usr_t tclass=file

Jul 21 18:13:50 j9saf-219 kernel: avc:  denied  { recvfrom } for  pid=1629 
exe=/usr/stow/JSAF5/src/JSAF/jsaf saddr=127.0.0.1 source=32773 
daddr=127.0.0.1 dest=111 netif=lo scontext=system_u:system_r:xdm_t 
tcontext=root:sysadm_r:sysadm_t tclass=udp_socket
Feb 20 15:24:14 j9saf-219 
marcid: /usr/stow/JSAF5/runscripts/../bin/jre/bin/java -classpath 
.:/usr/stow/JSAF5/runscripts/../bin/jre/lib/i18n.jar:/usr/stow/JSAF5/runscr
ipts/../bin/jre/lib/rt.jar:/usr/stow/JSAF5/runscripts/../classes 
-Djava.rmi.server.hostname=164.210.230.219 -
Dscriptfile=/usr/stow/JSAF5/runscripts/../bin/chdir.sh 
jsaf.marcid.MARCIdServer 0

Jul 22 04:03:13 j9saf-219 
marcid: /usr/stow/JSAF5/runscripts/../bin/jre/bin/java -classpath 
.:/usr/stow/JSAF5/runscripts/../bin/jre/lib/i18n.jar:/usr/stow/JSAF5/runscr
ipts/../bin/jre/lib/rt.jar:/usr/stow/JSAF5/runscripts/../classes 
-Djava.rmi.server.hostname=164.210.230.219 -
Dscriptfile=/usr/stow/JSAF5/runscripts/../bin/chdir.sh 
jsaf.marcid.MARCIdServer 0

Jul 22 04:06:28 j9saf-219 kernel: avc:  denied  { execute_no_trans } for  
pid=1193 exe=/bin/bash path=/usr/stow/JSAF5/src/JSAF/jsaf dev=08:03 
ino=1565642 scontext=system_u:system_r:initrc_t 
tcontext=safuser:object_r:usr_t tclass=file

Jul 22 04:07:19 j9saf-219 kernel: avc:  denied  { recvfrom } for  pid=1195 
exe=/usr/stow/JSAF5/src/JSAF/jsaf saddr=164.210.230.219 
source=32769 daddr=224.8.8.1 dest=3597 netif=eth0 
scontext=system_u:system_r:initrc_t tcontext=system_u:system_r:initrc_t 
tclass=udp_socket

Jul 22 04:08:30 j9saf-219 kernel: avc:  denied  { rawip_send } for  
pid=1193 exe=/usr/stow/JSAF5/src/JSAF/jsaf saddr=164.210.230.219 
daddr=224.50.0.201 netif=eth0 scontext=system_u:object_r:unlabeled_t 
tcontext=system_u:object_r:node_t tclass=node

Thanks for any help you can give me.  I have set this box up and am 
getting riddled with the messages.  In console mode I get several messages 
everytime I type a command.

Nate Brazell


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
