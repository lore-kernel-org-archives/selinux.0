Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17384
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:55:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA05138
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:55:15 GMT
Received: from centauri.ee.ucla.edu (centauri.ee.ucla.edu [128.97.92.179])
	by jazzswing.ncsc.mil  with ESMTP id RAA05134
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:55:14 GMT
Received: from localhost (simonhan@localhost)
	by centauri.ee.ucla.edu (8.8.8+Sun/8.8.8(ee-0002)) with ESMTP id KAA19564
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 10:55:44 -0700 (PDT)
Date: Thu, 11 Jul 2002 10:55:44 -0700 (PDT)
From: Simon Han <simonhan@ee.ucla.edu>
To: selinux@tycho.nsa.gov
Subject: dhcpc_t
In-Reply-To: <Pine.GSO.4.33.0207110857160.822-100000@raven>
Message-ID: <Pine.GSO.4.10.10207111032020.19504-100000@centauri.ee.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
	It seems to me that normal user needs to have packet_socket
permission.  Of course, I can add directly to macros/user_mmacros.te, but
I would like to seek for advice before doing so since packet_socket is
relatively powerful.

The message is following,

Jul 11 10:25:26 dhcp2-200 kernel: avc:  denied  { recvfrom } for  pid=693
exe=/sbin/ypbind saddr=206.17.239.200 source=17664 daddr=206.17.239.33
dest=84 netif=eth0 scontext=system_u:system_r:dhcpc_t
tcontext=system_u:system_r:ypbind_t tclass=packet_socket

Jul 11 10:25:39 dhcp2-200 kernel: avc:  denied  { recvfrom } for  pid=1807
exe=/usr/bin/gnome-session saddr=206.17.239.200 source=17664
daddr=206.17.239.33 dest=116 netif=eth0 scontext=system_u:system_r:dhcpc_t
tcontext=simon:user_r:user_t tclass=packet_socket

Jul 11 10:26:16 dhcp2-200 kernel: avc:  denied  { recvfrom } for  pid=5833
exe=/usr/kerberos/bin/telnet saddr=206.17.239.200 source=17680
daddr=128.97.92.179 dest=53 netif=eth0 scontext=system_u:system_r:dhcpc_t
tcontext=simon:sysadm_r:sysadm_t tclass=packet_socket


Thanks in advance,
Simon


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
