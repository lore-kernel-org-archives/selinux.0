Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2MKjWx6027628
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 15:45:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2MKg2lY017562
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 20:42:02 GMT
Received: from eos.telenet-ops.be (eos.telenet-ops.be [195.130.132.40])
	by jazzswing.ncsc.mil  with ESMTP id h2MKg2KX017559
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 20:42:02 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eos.telenet-ops.be (Postfix) with SMTP id 2074620237
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 21:45:31 +0100 (CET)
Received: from kabel.telenet.be (D5775F15.kabel.telenet.be [213.119.95.21])
	by eos.telenet-ops.be (Postfix) with ESMTP id 15EFA20139
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 21:45:31 +0100 (CET)
Date: Sat, 22 Mar 2003 21:45:30 +0100
From: Kurt Roeckx <Q@ping.be>
To: selinux@tycho.nsa.gov
Subject: ping problems.
Message-ID: <20030322204530.GA20526@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ping6 doesn't seem to work to work when pinging localhost (::1).
It does work in case I ping a remote host however.

I get this error:
avc:  denied  { recvfrom } for  pid=1631 exe=/bin/ping6 netif=lo
scontext=kurt:sysadm_r:ping_t tcontext=system_u:system_r:kernel_t
tclass=rawip_socket

I think the tclass should be icmp_socket_t instead, for which is
has permission to use recvfrom.

Then there is a problem for both ping and ping6 if you try to use
the -I parameter.  You get:

avc:  denied  { ioctl } for  pid=1641 exe=/bin/ping6
path=socket:[8429] dev=00:00 ino=8429
scontext=kurt:sysadm_r:ping_t tcontext=kurt:sysadm_r:ping_t
tclass=rawip_socket

avc:  denied  { ioctl } for  pid=1647 exe=/bin/ping
path=socket:[8439] dev=00:00 ino=8439
scontext=kurt:sysadm_r:ping_t tcontext=kurt:sysadm_r:ping_t
tclass=rawip_socket


Kurt


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
