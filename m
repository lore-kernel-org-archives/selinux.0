Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00709
	for <selinux@tycho.nsa.gov>; Sat, 2 Feb 2002 11:43:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA11565
	for <selinux@tycho.nsa.gov>; Sat, 2 Feb 2002 16:42:59 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
        by jazzband.ncsc.mil  with ESMTP id QAA11561 for <selinux@tycho.nsa.gov>; Sat, 2 Feb 2002 16:42:58 GMT
Received: from [10.0.1.17] (goedel.xiat.org [10.0.1.17])
	(authenticated)
	by khaipur.xiat.org (8.11.6/8.11.6) with ESMTP id g12GhJ615412
	for <selinux@tycho.nsa.gov>; Sat, 2 Feb 2002 08:43:19 -0800
Date: Sat, 02 Feb 2002 08:43:08 -0800
From: Paul Krumviede <pwk@acm.org>
To: selinux <selinux@tycho.nsa.gov>
Subject: strange audit messages from the dhcpc_t domain
Message-ID: <22613336.1012639388@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i just noticed a few strange denials on a RH 7.2 system running the 
2.4.17-kernel
version. the machine is using DHCP on eth1 and gets assigned an address of
172.16.218.138.

1)	Feb  1 04:02:05 fermat kernel: avc:  denied  { recvfrom } for  pid=2235 
	exe=/usr/sbin/sendmail saddr=0.4.172.16 daddr=218.138.0.0 netif=eth1 
	scontext=system_u:system_r:dhcpc_t
	tcontext=system_u:object_r:netmsg_eth1_t tclass=packet_socket

why is sendmail running in the dhcpc_t domain? and the saddr and daddr 
values look
mangled.

2)	Feb  2 02:37:10 fermat kernel: avc:  denied  { recvfrom } for
	saddr=172.16.218.254 source=17680
	daddr=172.16.218.138 dest=328
	netif=eth1
 	scontext=system_u:system_r:dhcpc_t
	tcontext=system_u:object_r:netmsg_eth1_t tclass=packet_socket

this looks correct, while

3)	Feb  2 02:42:06 fermat kernel: avc:  denied  { recvfrom } for
	saddr=0.8.172.16
	daddr=218.1.0.0
	netif=eth1 scontext=system_u:system_r:dhcpc_t
	tcontext=system_u:object_r:netmsg_eth1_t
	tclass=packet_socket

this also seems to have mangled the saddr/daddr fields (and if i reconstruct
the fields as 172.16.218.1, i don't think that machine would ever emit DHCP
or BOOTP messages, although i could be wrong).

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
