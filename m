Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA10862
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 04:50:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA02465
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 08:48:52 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA02461
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 08:48:50 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id F229B92472
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 18:50:12 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 2A33D6AE
	for <selinux@tycho.nsa.gov>; Thu, 19 Sep 2002 10:50:05 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: logging error
Date: Thu, 19 Sep 2002 10:50:04 +0200
MIME-Version: 1.0
Message-Id: <200209191050.04728.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm seeing messages such as the following, I believe that this must be wrong.  
192.5.41.40 is an address not in my range.  203.15.120.110 is a ppp modem 
user.  klogd is not involved in the communication...

Sep 19 18:45:57 caesar kernel: avc:  denied  { udp_send } for  pid=341 
exe=/sbin/klogd saddr=192.5.41.40 source=17680 daddr=203.15.120.110 dest=76 
netif=ppp0 scontext=system_u:object_r:netmsg_eth1_t 
tcontext=system_u:object_r:netif_t tclass=netif
Sep 19 18:45:57 caesar kernel:
Sep 19 18:45:57 caesar kernel: avc:  denied  { udp_send } for  pid=341 
exe=/sbin/klogd saddr=192.5.41.40 source=17680 daddr=203.15.120.110 dest=76 
netif=ppp0 scontext=system_u:object_r:netmsg_eth1_t 
tcontext=system_u:object_r:node_t tclass=node


-- 
There is no point PGP/GPG signing an email unless the signature can be
verified.  If you post to a list then don't sign the message unless your
key is available on public key servers and has been signed by someone
who is in the web of trust, otherwise you just waste bandwidth and CPU.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
