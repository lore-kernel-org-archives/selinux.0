Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h35NSdI4011166
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 18:28:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h35NScxH026651
	for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 23:28:39 GMT
Received: from eos.telenet-ops.be (eos.telenet-ops.be [195.130.132.40])
        by jazzband.ncsc.mil  with ESMTP id h35NScDl026648 for <selinux@tycho.nsa.gov>; Sat, 5 Apr 2003 23:28:38 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eos.telenet-ops.be (Postfix) with SMTP id 1270F1FF02
	for <selinux@tycho.nsa.gov>; Sun,  6 Apr 2003 01:28:38 +0200 (CEST)
Received: from kabel.telenet.be (D5775F15.kabel.telenet.be [213.119.95.21])
	by eos.telenet-ops.be (Postfix) with ESMTP id B2C871FF30
	for <selinux@tycho.nsa.gov>; Sun,  6 Apr 2003 01:28:37 +0200 (CEST)
Date: Sun, 6 Apr 2003 01:28:37 +0200
From: Kurt Roeckx <Q@ping.be>
To: selinux@tycho.nsa.gov
Subject: ipv6 tunnel problem.
Message-ID: <20030405232837.GA14825@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not exactly sure what causes it, but I got those 2 messages a
few times so far:

avc:  denied  { rawip_send } for  pid=3789
exe=/usr/local/ircd/sbin/ircd saddr=x.x.x.x
daddr=y.y.y.y netif=eth0
scontext=system_u:object_r:unlabeled_t
tcontext=system_u:object_r:netif_eth0_t tclass=netif

avc:  denied  { rawip_send } for  saddr=x.x.x.x
daddr=y.y.y.y netif=eth0
scontext=system_u:object_r:unlabeled_t
tcontext=system_u:object_r:netif_eth0_t tclass=netif

x.x.x.x is the local ipv4 address, and y.y.y.y is the ipv4
endpoint of my ipv6 (sit) tunnel.


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
